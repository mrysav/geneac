# frozen_string_literal: true

# Controls import and export of data
class DataController < ApplicationController
  def index
    @import = Import.new
  end

  def import
    import_file = Import.new(import_params)
    # TODO: Don't default to these options in the future
    import_file.merge = false
    import_file.format = 'json'
    return unless import_file.save

    case import_file.format
    when 'json'
      ImportJsonJob.perform_later(import_file.id, import_file.merge)
    end

    flash[:notice] = "Import #{import_file.id} scheduled."
    redirect_to data_path
  end

  def export; end

  private

  def import_params
    params.require(:import).permit(:format, :merge, :file)
  end
end
