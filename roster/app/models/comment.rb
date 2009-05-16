class Comment < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :title
  belongs_to :user
end
