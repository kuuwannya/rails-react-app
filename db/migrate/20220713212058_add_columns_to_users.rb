class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gender, :integer, null:false, default: 0, after: :nickname
    add_column :users, :birthday, :date, after: :email
    add_column :users, :profile, :string, limit: 1000, after: :birthday
    add_column :users, :prefecture, :integer, null:false, default: 1, after: :profile

    remove_column :users, :nickname, :string
  end
end
