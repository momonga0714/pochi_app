class CreateResipiImages < ActiveRecord::Migration[5.2]
  def change
    create_table :resipi_images do |t|
      t.string :image, null: false
      t.references :main, foreign_key: true
      t.references :sub, foreign_key: true
      t.references :soop, foreign_key: true
      t.timestamps
    end
  end
end
