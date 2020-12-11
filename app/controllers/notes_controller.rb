# frozen_string_literal: true

# Controller for displaying notes (editing controlled by Administrate)
class NotesController < ApplicationController
  def show
    @note = Note.where(friendly_url: params[:friendly_url]).first
    authorize @note
    @tagged_people = policy_scope(@note.resolved_people)
  end
end
