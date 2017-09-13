class RenameIntroductionColumnToProfile < ActiveRecord::Migration
  def change
    rename_column :users, :introduction, :profile  #Introductionは長いのでprofileにする
  end
end
