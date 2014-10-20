ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "My tiny url" do 


	
end