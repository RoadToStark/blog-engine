class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :upvotes
      t.integer :downvotes

      t.belongs_to :article
      t.belongs_to :user
      t.timestamps
    end
  end
end
