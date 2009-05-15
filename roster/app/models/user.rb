require 'net/ldap'

class User < ActiveRecord::Base
  has_many :comments
	has_and_belongs_to_many :roles
  validates_presence_of :name
  validates_presence_of :netid
  validates_uniqueness_of :netid
	validates_presence_of :roles

  def self.user_options
      all.collect {|x| [x.name, x.id]}
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
          # y entry
          new_user.name = [entry['givenname'], entry['sn']].join(" ")
          # self.email = "#{entry['mail']}"
          # self.college = entry['college'].first
          # self.phone = entry['studentphonenumber'].first
          # self.class_year = entry['class'].first
        end
      end
      new_user.save if should_save
    rescue Exception => e
      flash[:notice] = "Failed to add user: " + e.message
      errors.add_to_base "LDAP Error: " + $! # Will trigger an error, LDAP is probably down
      return 
    else
      new_user
    end
  end
  
  def self.mass_add (netids)
    netids = netids.split(/\W+/)
    errors = Array.new
    begin
      netids.each do |n|
        user = import_from_ldap(n, true)
        errors << user.netid if user.new_record?
      end
    rescue Exception => e
    end
    errors
  end

	def self.mass_add(netids)
		netids.split(/\W+/)
		failed = Array.new

		netids.each do |n|
			new_user = import_from_ldap(n, true)
		#error message, hopefully
			if user.new?
				failed.push(user.new_record?)
			end				
		end
	end

end
