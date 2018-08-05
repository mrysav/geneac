# frozen_string_literal: true

# Parent class for all importer jobs
class ImportJobs < ApplicationJob
  # These are helpers for import jobs

  def download_attachment(import_id)
    import = Import.find(import_id)
    local_fname = "/tmp/#{Time.now.to_i}_#{import.id}_#{import.file.filename}"
    File.open(local_fname, 'wb') do |local_file|
      import.file.download do |chunk|
        local_file.write(chunk)
      end
    end
    local_fname
  end

  # Attempts to detect compression and returns an uncompressed object
  def decompress(payload)
    ActiveSupport::Gzip.decompress(payload)
  rescue Zlib::GzipFile::Error
    Rails.logger.info 'No GZIP compression detected. Continuing.'
    payload
  end

  # Attempts to parse a date with great flexbility and
  # the possibility of abysmal accuracy
  # may return nil
  def parse_date(raw_date)
    # don't even try
    return nil if raw_date.blank?

    # first try EDTF parsing
    date = Date.edtf(raw_date)

    # if EDTF parse fails, use Chronic instead
    if date.nil?
      # Rails.logger.info "EDTF date parsing unsuccessful for \"" + raw_date + "\", attempting Chronic parsing (possibly less accurate)"
      # TODO: Add more to this for more accuracy?
      parsed = Chronic.parse(raw_date)
      date = parsed.strftime('%Y-%m-%d') if parsed
    end

    date
  end

  def insert_people(people)
    people.each do |data|
      p = Person.create(data.except('gid'))
      if p.save
        data['id'] = p['id']
      else
        Rails.logger.warn 'Error saving ' + data['first_name'] + ' ' + data['last_name'] + '!'
      end
    end
  end

  def update_people(people)
    Rails.logger.info 'updating people'
    people.each do |data|
      matched = Person.where(first_name: data['first_name'], last_name: data['last_name'])

      # no match - insert the person
      if !matched || matched.count < 1
        Rails.logger.info 'No matches found for ' + data['first_name'] + ' ' + data['last_name']
        p = Person.create(data.except('gid'))

      # exactly one match
      elsif matched.count == 1
        Rails.logger.info 'Match found for ' + data['first_name'] + ' ' + data['last_name']
        p = matched[0]
        p.update(data.except('gid'))

      # more than one match
      else
        Rails.logger.info 'Multiple matches found for ' + data['first_name'] + ' ' + data['last_name']
        p = matched[0]
        hi_score = match_score(p, data)
        matched.each do |m|
          score = match_score(m, data)
          if score >= hi_score
            hi_score = score
            p = m
          end
        end

        p.update(data.except('gid'))
      end

      if p.save
        data['id'] = p['id']
      else
        Rails.logger.warn 'Error saving ' + data['first_name'] + ' ' + data['last_name'] + '!'
      end
    end
  end

  private

  def match_score(person, p_hash)
    (parse_date(p_hash['date_of_birth']) == person.date_of_birth ? 1 : 0) +
      (parse_date(p_hash['date_of_death']) == person.date_of_death ? 1 : 0) +
      (p_hash['birthplace'] == person.birthplace ? 1 : 0) +
      (p_hash['burialplace'] == person.burialplace ? 1 : 0)
  end
end
