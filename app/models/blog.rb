class Blog < ActiveRecord::Base
  has_many :articles
  has_and_belongs_to_many :users

  validates_presence_of :title
  validates_presence_of :description

end
