# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

# Define a simple DataMapper model.
class Person
  include DataMapper::Resource

  property :id,           Serial,   key: true
  property :created_at,   DateTime
  property :name,         String,   length: 255
  property :gender,       String,   length: 255
  property :age,          Integer
  property :description,  Text
  property :avatar,       String,   length: 255
end

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!

# Clean database
DataMapper.auto_migrate!

# Populate database
people = [
  [ "Zilla", "female", 24, "Not sure if serios…", "http://xoart.link/200/200/woman/22" ],
  [ "Nach", "male", 32, "I like pizza", "http://xoart.link/200/200/man/26" ]
]

people.each do |name, gender, age, description, avatar|
  Person.create( name: name, gender: gender, age: age, description: description, avatar: avatar )
end

get '/' do
  redirect 'https://github.com/naoisegolden/tinder-api', 'There is no root in this API'
end

# Route to show all People, ordered like a blog
get '/people' do
  content_type :json
  @people = Person.all(:order => :created_at.desc)

  @people.to_json
end

# READ: Route to show a specific Person based on its `id`
get '/person/:id' do
  content_type :json
  @person = Person.get(params[:id].to_i)

  if @person
    @person.to_json
  else
    halt 404
  end
end