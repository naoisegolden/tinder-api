require './app'
require 'sinatra/cross_origin'

configure do
  enable :cross_origin
end

run Sinatra::Application