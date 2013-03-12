$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'rubygems'
require 'sinatra'
require 'bot.rb'

# Run the app!
run Sinatra::Application