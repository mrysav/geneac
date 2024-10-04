class SaveAllCitations < ActiveRecord::Migration[6.1]
  def change
    Citation.find_each(&:save!)
  end
end
