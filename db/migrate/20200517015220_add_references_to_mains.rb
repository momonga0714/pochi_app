class AddReferencesToMains < ActiveRecord::Migration[5.2]
  def change
    add_reference :mains, :user, null: false, foreign_key: true
  end
end
