class CreateMains < ActiveRecord::Migration[5.2]
  def change
    create_table :mains do |t|
      t.string :main_name
      t.references :menu, foreign_key: true
      t.integer :genre, foreign_key: true
      t.integer :type, foreign_key: true
      t.text :comment
      t.timestamps
    end
  end
end
