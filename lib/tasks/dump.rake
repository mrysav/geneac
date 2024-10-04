# frozen_string_literal: true

require "fileutils"
require "zip"
require "backup/postgres_dumper"
require "backup/blob_dumper"

namespace :dump do
  desc "Dump the Postgres database to stdout."
  task database: :environment do
    logger = Rails.logger
    Rails.logger = Logger.new($stderr)

    Backup::PostgresDumper.new.dump do |io|
      puts io.read
    end

    Rails.logger = logger
  end

  desc "Dump the contents of the blob store to a given directory."
  task :storage, [:outdir] => :environment do |_task, args|
    exit(1) if args.outdir.nil?

    FileUtils.mkdir_p(args.outdir)

    dumper = Backup::BlobDumper.new
    dumper.dump do |path, bytes|
      dirname = File.join(args.outdir, File.dirname(path))
      FileUtils.mkdir_p(dirname)
      File.binwrite(File.join(args.outdir, path), bytes)
    end
  end

  desc "Dump the contents of the database and blob store to a zip file."
  task :all, [:zip] => :environment do |_task, args|
    exit(1) if args[:zip].nil?

    Zip::OutputStream.open(args[:zip]) do |zio|
      zio.put_next_entry "database.sql"
      Backup::PostgresDumper.new.dump do |io|
        zio.write(io.read)
      end

      base = "storage/"
      blobs = Backup::BlobDumper.new
      blobs.dump do |path, bytes|
        name = "#{base}#{path}"
        zio.put_next_entry name
        zio.write(bytes)
      end
    end
  end
end
