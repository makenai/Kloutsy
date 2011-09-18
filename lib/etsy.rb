require 'httparty-icebox'
require 'httparty'

class Etsy
  include HTTParty
  include HTTParty::Icebox
  cache :store => 'file', :timeout => 3000, :location => '/tmp/party'  
  
  KEY = 'YOUR KEY HERE'
  base_uri 'http://openapi.etsy.com'
  
  # Get detail on an individual listing
  def self.listing( id )
    get("/v2/listings/#{id}?api_key=#{KEY}")['results'].first
  end
  
  def self.listing_image( id )
    get("/v2/listings/#{id}/images?api_key=#{KEY}")['results']
  end
  
  # Get shop details
  def self.shop( name )
    get("/v2/shops/#{name}?api_key=#{KEY}")['results'].first
  end
  
  # Get active listings for a shop
  def self.shop_listings( shop )
    get("/v2/shops/#{shop}/listings/active?api_key=#{KEY}")['results']
  end
  
  # Get a list of featured users
  def self.featured_users
    get("/v2/featured/users?api_key=#{KEY}")['results']
  end
  
  # Get stores beloning to the user
  def self.user_shops( user_id )
    get("/v2/users/#{user_id}/shops?api_key=#{KEY}")
  end
  
end