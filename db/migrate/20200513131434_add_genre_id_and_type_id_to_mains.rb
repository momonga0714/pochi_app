class AddGenreIdAndTypeIdToMains < ActiveRecord::Migration[5.2]
  def change
    add_column :mains, :genre_id, :integer, null: false
    add_column :mains, :type_id, :integer, null: false
  end
end
