class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :upvotes, :default => 0
      t.integer :views, :default => 0

      t.belongs_to :blog
      t.belongs_to :user
      t.timestamps
    end
  end
end
