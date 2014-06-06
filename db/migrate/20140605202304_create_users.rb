class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email

      t.timestamps
    end

    create_table :blogs_user, id: false do |t|
      t.belongs_to :user
      t.belongs_to :blog
      t.string :role
    end
  end
end
