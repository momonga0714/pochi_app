class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :sub_name
      t.references :menu, foreign_key: true
      t.integer :genre_id, null: false
      t.integer :type_id, null: false
      t.text :comment
      t.timestamps
    end
  end
end
