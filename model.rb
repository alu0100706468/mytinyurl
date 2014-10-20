class User
	include DataMapper::Resource
		property :id, Serial
		property :uid, BigInt
		property :name, String
		property :nickname, String		#Variable especial para GitHub
		property :email, String
		property :imagen, Text
		property :created_at, DateTime
		
end


class ShortenedUrl
	include DataMapper::Resource
		property :id, Serial 		#Identifica la URL corta
		property :uid, String 		#Identifica al usuario registrado (el no registrado es igual a 0)
		property :url, Text 		#URL sin acortar
		property :url2, Text 		#URL personalizada
end