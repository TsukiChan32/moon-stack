require 'sinatra'
require_relative 'db'

get '/' do
  erb :index
end
