class SaveAllCitations < ActiveRecord::Migration[6.1]
  def change
    Citation.all.each(&:save!)
  end
end
