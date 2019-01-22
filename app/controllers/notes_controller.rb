# frozen_string_literal: true

# Controller for displaying notes (editing controlled by Administrate)
class NotesController < ApplicationController
  helper MarkdownHelper

  def show
    @note = Note.find(params[:id])
  end
end
