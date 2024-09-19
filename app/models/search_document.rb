# frozen_string_literal: true

# Models a single entry in the full text search table
class SearchDocument < ApplicationRecord
  belongs_to :searchable, polymorphic: true, optional: false

  before_save :set_key
  after_save_commit :update_fts
  after_destroy_commit :delete_fts

  attr_writer :content

  def set_key
    self.key = searchable.to_s.foreign_key if key.blank?
  end

  def update_fts
    delete_fts
    self.class.connection.execute <<~SQL.squish
      INSERT INTO fts_search_documents(`key`, `content`)
      VALUES ('#{key}', '#{content}');
    SQL
  end

  def delete_fts
    self.class.connection.execute <<~SQL.squish
      DELETE FROM fts_search_documents WHERE key = '#{key}';
    SQL
  end

  def self.search(search_query)
    fts_query = <<~SQL.squish
      SELECT s.* FROM fts_search_documents
      LEFT JOIN search_documents s ON fts_search_documents.key = s.key
      WHERE fts_search_documents MATCH ?
      ORDER BY rank;
    SQL

    SearchDocument.find_by_sql(Arel.sql(fts_query, search_query))
  end

  private

  attr_reader :content
end
