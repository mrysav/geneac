# frozen_string_literal: true

# Models a single entry in the full text search table
class SearchDocument < ApplicationRecord
  belongs_to :searchable, polymorphic: true, optional: false

  before_save :set_key
  after_save_commit :update_fts
  after_destroy_commit :delete_fts

  attr_writer :content

  # Internal class for accessing the fts_search_documents table
  class FtsSearchDocument < ApplicationRecord
    self.table_name = "fts_search_documents"
    self.primary_key = :key
  end

  def set_key
    self.key = searchable.to_s.foreign_key if key.blank?
  end

  def update_fts
    delete_fts
    SearchDocument::FtsSearchDocument.create!(key: key, content: content)
  end

  def delete_fts
    SearchDocument::FtsSearchDocument.delete_by(key: key)
  end

  # This does some funky manuevering to query the fts_search_documents
  # table for the query, but return an ActiveRecord::Relation of SearchDocuments.
  def self.search(search_query, privacy_scope)
    SearchDocument
      .select("s.*")
      .from("fts_search_documents")
      .joins("LEFT JOIN search_documents s ON fts_search_documents.key = s.key")
      .where("fts_search_documents MATCH ? AND s.privacy_scope = ?", search_query, privacy_scope)
      .order("rank")
  end

  private

  attr_reader :content
end
