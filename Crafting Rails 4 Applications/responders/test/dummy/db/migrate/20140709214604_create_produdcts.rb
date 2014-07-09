class CreateProdudcts < ActiveRecord::Migration
  def change
    create_table :produdcts do |t|
      t.string :name

      t.timestamps
    end
  end
end
