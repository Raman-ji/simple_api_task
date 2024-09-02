class RenameLoginToLoggedIn < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :login, :logged_in
  end
end
