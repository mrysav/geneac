class DropContentFromNotes < ActiveRecord::Migration[6.0]
  def up
    return unless column_exists? :notes, :content

    Note.find_each do |n|
      if n.content.present?
        throw "Some notes still have content. Run `rake content:migrate_rich_text` and re-run these migrations."
      end
    end

    remove_column :notes, :content
  end

  def down
    add_column :notes, :content
  end
end
