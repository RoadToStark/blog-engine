class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :upvotes, :default => 0
      t.integer :downvotes, :default => 0

      t.belongs_to :article
      t.belongs_to :user
      t.timestamps
    end
  end
end
