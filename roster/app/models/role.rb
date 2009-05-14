class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.role_options
    all.collect { |r| [r.name, r.id]}
  end
end
