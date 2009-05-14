require 'net/ldap'

class User < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :roles

  validates_presence_of :name
  validates_presence_of :netid
  validates_uniqueness_of :netid

  def self.user_options
      all.collect {|x| [x.name, x.id] }
  end

  def self.import_from_ldap(netid, should_save = false)
    # Setup our LDAP connection
    ldap = Net::LDAP.new( :host => "directory.yale.edu", :port => 389 )
    new_user = User.new(:netid => netid)
    begin
      # We filter results based on netid
      filter = Net::LDAP::Filter.eq( "uid", netid)
      ldap.open do |ldap|
        # Search, limiting results to yale domain and people
        ldap.search( :base => "ou=People,o=yale.edu", :filter => filter, :return_result => false ) do |entry|
          #y entry
          new_user.name = [entry['givenname'], entry['sn']].join(" ")
        end
      end
    rescue Exception => e
      new_user.errors.add_to_base "LDAP Error: " + $! # Will trigger an error, LDAP is probably down
    end
    new_user.save if should_save
    new_user
  end
end
