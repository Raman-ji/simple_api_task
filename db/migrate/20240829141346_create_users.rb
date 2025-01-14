class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.boolean :login, default: false

      t.timestamps
    end
  end
end
