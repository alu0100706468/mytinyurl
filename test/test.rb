ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require 'bundler/setup'
require 'sinatra'
require 'data_mapper'


include Rack::Test::Methods

def app
	Sinatra::Application
end

configure :test do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/my_shortened_urls.db")
end

DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative '../model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

describe "My tiny url" do 

	before :all do
		@consult = ShortenedUrl.first_or_create(:uid => '0', :url => "http://www.google.es")
		@consult1 = ShortenedUrl.last(:uid=> '0')
		@pag = "http://www.google.es"
	end


	it "Deberia devolver que google esta dentro en la BBDD" do
		assert @pag, @consult1.url
	end

	it "Deberia devolver que el uid de la consulta es 0" do
		assert 0, @consult1.url
	end
	
end