class Comment < ActiveRecord::Base
  validates_presence_of :user
  belongs_to :user
end
