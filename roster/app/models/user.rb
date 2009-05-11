class User < ActiveRecord::Base
  has_many :comments
  validates_presence_of :name
  validates_presence_of :netid

  def self.user_options
      all.collect {|x| [x.name, x.id] }
  end
end
