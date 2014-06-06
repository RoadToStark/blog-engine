class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :email
      t.string :auth_token

      t.timestamps
    end

    create_table :blogs_user, id: false do |t|
      t.belongs_to :user
      t.belongs_to :blog
      t.string :role
    end
  end
end
