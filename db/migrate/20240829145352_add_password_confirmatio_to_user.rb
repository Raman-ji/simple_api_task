class AddPasswordConfirmatioToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_confirmation, :string
  end
end
