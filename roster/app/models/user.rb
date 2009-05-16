require 'net/ldap'

class User < ActiveRecord::Base
  has_many :comments
	has_and_belongs_to_many :roles

  before_validation :check_role

  validates_presence_of :name
  validates_presence_of :netid
  validates_uniqueness_of :netid
	validates_presence_of :roles

  def self.user_options
		all.collect{|x| [x.name, x.id]}
  end

  def self.import_from_ldap(netid, should_save = false)
    # Setup our LDAP connection
    ldap = Net::LDAP.new( :host => "directory.yale.edu", :port => 389 )
    begin
      # We filter results based on netid
      filter = Net::LDAP::Filter.eq("uid", netid)
      new_user = User.new(:netid => netid)
      ldap.open do |ldap|
        # Search, limiting results to yale domain and people
        ldap.search(:base => "ou=People,o=yale.edu", :filter => filter, :return_result => false) do |entry|
          new_user.name = [entry['givenname'], entry['sn']].join(" ")
        end
      end
      new_user.save if should_save
    rescue Exception => e
      new_user.errors.add_to_base "LDAP Error #{e.message}" # Will trigger an error, LDAP is probably down
    end
    new_user
  end

	def self.mass_add(netids)
		failed = []

		netids.split(/\W+/).each do |n|
			user = import_from_ldap(n, true)
		  #error message, hopefully
			if user.new_record?
				failed << "From netid #{user.netid}: #{user.errors.full_messages.to_sentence}"
			end
		end

		failed
	end

  private

  def check_role
    guest = Role.find_by_name("guest") || Role.create!(:name=>"guest")
    self.roles << guest if roles.empty?
  end
end
