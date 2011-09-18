require 'httparty-icebox'
require 'httparty'
require 'cgi'

class Twitter
  include HTTParty  
  include HTTParty::Icebox
  cache :store => 'file', :timeout => 3000, :location => '/tmp/party'
  base_uri 'http://search.twitter.com'
  
  def self.search( term )
    get( "/search.json?q=#{CGI::escape(term)}" )['results'] rescue []
  end
  
  def self.klouty_about( topic )
    users = []

    # Find people who are bragging about their +K
    # I received +K in washington dc from Marie Leslie    
    braggers = search("I received +K in #{topic}")
    braggers.each do |bragger|
      users << { :user => bragger['from_user'], :text => bragger['text'], :type => 'bragger' }
    end

    # Find people who are giving klout about topics
    # I gave @KatarinaZue +K about Facebook on @klout
    oversharers = search("I gave +K about #{topic} on @klout")
    oversharers.each do |oversharer|
      matches = oversharer['text'].match(/I gave \@(\w+)/)
      if matches
        users << { :user => matches[1], :text => oversharer['text'], :type => 'oversharer' }
      end
    end

    return users
  end

end