class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :article_id, :content, :presence => true
end
