require 'httparty-icebox'
require 'httparty'

class Klout
  include HTTParty
  include HTTParty::Icebox
  cache :store => 'file', :timeout => 3000, :location => '/tmp/party'  
  
  base_uri 'http://api.klout.com'
  KEY = 'YOUR KEY HERE'
  # debug_output $stderr
  
  # Get topics for a user
  def self.topics( user )
    get( "/1/users/topics.json?users=#{user}&key=#{KEY}" )['users'][0]['topics'] rescue []
  end
  
end