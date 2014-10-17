class ShortenedUrl
  include DataMapper::Resource
  property :user_id, Bigint
  property :id, Serial
  property :url, Text
  property :url2, Text
end
