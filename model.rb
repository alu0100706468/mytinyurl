class User
	include DataMapper::Resource
		property :id, Serial
		property :uid, Integer
		property :name, String
		property :nickname, String
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