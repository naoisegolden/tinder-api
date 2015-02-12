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
  property :latitude,     String,   length: 255
  property :longitude,    String,   length: 255
end

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!

# Clean database
DataMapper.auto_migrate!

# Populate database
base_url = "http://tinder-api.herokuapp.com"
people = [
  ["Admiral Ackbar", "male", 32, "It's a trap!", "#{base_url}/images/admiral-ackbar.jpeg", "41.385064", "2.173403"],
  ["Admiral Motti", "male", 28, "Looking for a new job...", "#{base_url}/images/admiral-motti.jpeg", "25.204849", "55.270783"],
  ["Bib Fortuna", "male", 26, "Interested in meeting my new overlord.", "#{base_url}/images/bib-fortuna.jpeg", "51.507351", "-0.127758"],
  ["Chewbacca", "male", 28, "Gnnnnhnggggggrrrhhhhhhhhhhh!", "#{base_url}/images/chewbacca.jpeg", "33.883378", "-116.609125"],
  ["Darth Vader", "male", 38, "Come to the dark side... we have cookies.", "#{base_url}/images/darth-vader.jpeg", "-82.862752", "-135.000000"],
  ["Han Solo", "male", 30, "I ain't in this for your revolution, and I'm not in it for you, princess. I expect to be well paid. I'm in it for the money.", "#{base_url}/images/han-solo.jpeg", "40.712784", "-74.005941"],
  ["Jabba The Hutt", "male", 55, "Not sure if hungry, or horny.", "#{base_url}/images/jabba-the-hutt.jpeg", "-23.550520", "-46.633309"],
  ["Lando Calrissian", "male", 29, "I am the best that can happen to you, unless I betray you.", "#{base_url}/images/lando-calrissian.jpeg", "27.700000", "85.333333"],
  ["Luke Skywalker", "male", 27, "I have father issues.", "#{base_url}/images/luke-skywalker.jpeg", "40.416775", "-3.703790"],
  ["Mon Mothma", "female", 29, "I am the leader of the Revolution and yet nobody knows me.", "#{base_url}/images/mon-mothma.jpeg", "59.913869", "10.752245"],
  ["Padme Amidala", "female", 24, "Some times I get lost in translation.", "#{base_url}/images/padme-amidala.jpeg", "55.676097", "12.568337"],
  ["Princess Leia", "female", 28, "Do these ensaimadas on my head make me look fat?", "#{base_url}/images/princess-leia.jpeg", "13.756331", "100.501765"],
  ["Sabe", "female", 27, "Some day I will be queen. I think it is on Mondays.", "#{base_url}/images/sabe.jpeg", "19.432608", "-99.133208"],
  ["Taun We", "female", 45, "I don't need make up.", "#{base_url}/images/taun-we.jpeg", "-34.603723", "-58.381593"],
  ["Yoda", "male", 99, "Size matters not. Look at me. Judge me by my size, do you? Hmm?", "#{base_url}/images/yoda.jpeg", "53.551085", "9.993682"]
]

people.each do |name, gender, age, description, avatar, latitude, longitude|
  Person.create( name: name, gender: gender, age: age, description: description, avatar: avatar, latitude: latitude, longitude: longitude )
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