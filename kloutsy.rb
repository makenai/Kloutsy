require 'sinatra'
require 'erb'
require './lib/klout'
require './lib/twitter'
require './lib/etsy'
require 'pp'

# Welcome Page
get '/' do
  erb :index
end

# Redirect on POST
post '/' do
  redirect "/shop/#{params[:shop]}"
end

# User analysis page
get '/shop/:shop' do |shop|
  @shop = Etsy.shop( shop )
  @listings = Etsy.shop_listings( shop )
  erb :shop
end

# Get users influental in a topic
get '/topic/:topic' do |topic|
  p Twitter.klouty_about( topic )
  "Your topic is #{topic}"
end

get '/listing/:id' do |listing_id|
  @topics = {}
  @listing = Etsy.listing( listing_id )
  @images  = Etsy.listing_image( listing_id ).slice(0,3)
  @listing['tags'].each do |tag|
    users = Twitter.klouty_about( tag.gsub('_',' ') )
    @topics[ tag ] = users.slice(0,5) unless users.empty?
  end
  erb :listing
end

# User analysis page
get '/reward/:user' do |user|
  topics = Klout.topics( user )
  topics.each do |topic|
    puts topic
  end
  "You are influental in stuff"
end
