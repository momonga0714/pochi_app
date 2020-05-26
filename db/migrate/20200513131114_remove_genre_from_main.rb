class RemoveGenreFromMain < ActiveRecord::Migration[5.2]
  def change
    remove_column :mains, :genre, :integer
    remove_column :mains, :type, :integer
  end
end
