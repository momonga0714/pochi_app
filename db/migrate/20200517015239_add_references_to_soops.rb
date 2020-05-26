class AddReferencesToSoops < ActiveRecord::Migration[5.2]
  def change
    add_reference :soops, :user, null: false, foreign_key: true
  end
end
