# frozen_string_literal: true

# Controller for displaying notes (editing controlled by Administrate)
class NotesController < ApplicationController
  def show
    @note = Note.find(params[:id])
    authorize @note

    @tagged_people = @note.tagged_people.map do |p|
      id = p.name.to_i
      person = Person.find(id) if Person.exists?(id)
      authorize person
      person
    end
  end
end
