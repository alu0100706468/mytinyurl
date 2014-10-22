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
		@consult = ShortenedUrl.first_or_create(:uid => '0', :url => "http://www.google.es", :url2 =>'google')
		@consult1 = ShortenedUrl.first(:uid=> '0')
		@pag = "http://www.google.es"
		@pagerror = "http://www.facebook.com"

	end


	it "Deberia devolver que google esta dentro en la BBDD" do
		assert @pag, @consult1.url
	end

	it "Deberia devolver que el uid de la consulta es 0" do
		assert 0, @consult1.url
	end

	it "Deberia devolver una url erronea" do
		refute_equal @pagerror, @consult.url
	end

	it "Deberia devolver un error ya que ese campo no acepta URLs" do
		refute_equal @pag, @consult.url2
	end
	
end