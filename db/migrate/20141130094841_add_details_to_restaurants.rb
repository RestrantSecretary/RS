class AddDetailsToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :TEL, :string
    add_column :restaurants, :URL, :string
    add_column :restaurants, :ffranch, :integer
    add_column :restaurants, :fspanish, :integer
    add_column :restaurants, :extraText1, :string
    add_column :restaurants, :extraText2, :string
    add_column :restaurants, :extraText3, :string
  end
end
