class DropContentFromNotes < ActiveRecord::Migration[6.0]
  def up
    return unless column_exists? :notes, :content

    Note.all.each do |n|
      unless n.content.blank?
        throw 'Some notes still have content. Run `rake content:migrate_rich_text` and re-run these migrations.'
      end

      remove_column :notes, :content
    end
  end

  def down
    add_column :notes, :content
  end
end
