class AddExtraUserData < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :addless, :string
    add_column :users, :age, :integer
    add_column :users, :introduction, :text
    add_column :users, :avatar, :string      
  end
end
