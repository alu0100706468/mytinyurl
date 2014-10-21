require 'dm-core'
require 'dm-migrations'

class User
	include DataMapper::Resource
		property :id, Serial
		property :uid, String
		property :name, String
		property :email, String
		property :imagen, Text
		property :created_at, DateTime
		
end


class ShortenedUrl
	include DataMapper::Resource
		property :id, Serial
		property :uid, String
		property :url, Text
		property :url2, Text
end