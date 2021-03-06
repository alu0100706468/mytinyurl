#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'omniauth-oauth2'
require 'omniauth-github'
require 'omniauth-google-oauth2'
require 'omniauth-facebook'
require 'uri'
require 'data_mapper'
require 'erubis'
require 'pp'
require 'haml'


configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/my_shortened_urls.db")
end
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end


DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

Base = 36

use OmniAuth::Builder do
	config = YAML.load_file 'config/config.yml'
  	provider :github, config['identifier'], config['secret']
  	provider :google_oauth2, config['identifier_g'], config['secret_g']
  	provider :facebook, config['identifier_t'], config['secret_t']
end

enable :sessions
set :session_secret, '*&(^#234a)'

helpers do
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

get '/' do
	if current_user
		@list = ShortenedUrl.all(:uid => current_user.id, :order => [:id.desc], :limit => 20)
	end
	
	haml :index

end


get '/auth/:name/callback' do
	@auth = request.env["omniauth.auth"]
	@user = User.first_or_create({ :uid => @auth["uid"]}, {
	:uid => @auth["uid"],
	:name => @auth["info"]["name"],
	:email => @auth["info"]["email"],
	:imagen => @auth["info"]["image"],
	:created_at => Time.now	})
	
	session[:user_id] = @user.id
	redirect '/'
end

get '/auth/failure' do
	redirect '/'
end

get '/sign_github' do 
	redirect '/auth/github'
	
end

get '/sign_google/?' do
	redirect '/auth/google_oauth2'
	
end

get '/sign_facebook/?' do 
	redirect '/auth/facebook'
	
end

["/sign_out/?", "/signout/?", "/log_out/?", "/logout/?"].each do |path|
get path do
	session.clear
	redirect '/'
	end
end


post '/' do

	
		puts "inside post '/': #{params}"
		uri = URI::parse(params[:url])
		pers = params[:personal]

		if uri.is_a? URI::HTTP or uri.is_a? URI::HTTPS then
			if current_user
				begin
					if pers == ""
						@short_url = ShortenedUrl.first_or_create(:uid => current_user.id, :url => params[:url])
					end
					if pers != ""
						consult = ShortenedUrl.first(:url2 => params[:personal])

						if consult == nil
							@short_url = ShortenedUrl.first_or_create(:uid => current_user.id, :url => params[:url], :url2 =>params[:personal])	
						else
							@error = true
						end
					end

					@list = ShortenedUrl.all(:uid => current_user.id, :order => [:id.desc], :limit => 20)
				rescue Exception => e
					puts "EXCEPTION!!!!!!!!!!!!!!!!!!!"
					pp @short_url
					puts e.message
				end
				@list = ShortenedUrl.all(:uid => current_user.id, :order => [:id.desc], :limit => 20)

			else
				begin
					if pers == ""
						@short_url = ShortenedUrl.first_or_create(:uid => '0', :url => params[:url])
					end
					if pers != ""
						consult = ShortenedUrl.first(:url2 => params[:personal])
						if consult == nil
							@short_url = ShortenedUrl.first_or_create(:uid => '0' , :url => params[:url], :url2 =>params[:personal])	
						else
							@error = true
						end
					end


				rescue Exception => e
					puts "EXCEPTION!!!!!!!!!!!!!!!!!!!"
					pp @short_url
					puts e.message
				end


			end
		else
			logger.info "Error! <#{params[:url]}> is not a valid URL"
		end

		haml :index

end

get '/:shortened' do
	puts "inside get '/:shortened': #{params}"

	short_url = ShortenedUrl.first(:id => params[:shortened].to_i(Base))

	if short_url == nil
		short_url = ShortenedUrl.first(:url2 => params[:shortened])
	end

	redirect short_url.url, 301
end

error do
	haml :index
end
