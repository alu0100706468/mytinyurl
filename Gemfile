source "http://rubygems.org"

gem 'sinatra'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'pry' 
gem 'erubis'
gem 'data_mapper'
gem 'sinatra-contrib'
gem 'haml'


group :production do
	gem "pg"
	gem "dm-postgres-adapter"
end

group :development do
	gem "sqlite3"
	gem "dm-sqlite-adapter"
end

group :test do
	gem "sqlite3"
	gem "dm-sqlite-adapter"
    gem "rack-test"
    gem "rake"
end