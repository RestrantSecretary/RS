class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.integer :rank
      t.integer :price
      t.integer :fjpn
      t.integer :fchina
      t.integer :fitarian
      t.integer :fother
      t.integer :sdate
      t.integer :sconpa
      t.integer :sfever
      t.integer :sother

      t.timestamps
    end
  end
end
