class RenameAddressFixed < ActiveRecord::Migration
  def change
    rename_column :users, :addless, :address
  end
end
