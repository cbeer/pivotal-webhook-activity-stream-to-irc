$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra'
require 'bot.rb'

# Run the app!
run Sinatra::Application