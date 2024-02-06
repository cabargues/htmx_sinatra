require 'rubygems'
require 'bundler'
require './app'
require 'sequel'

Bundler.require

configure do
  set :server, :puma
  enable :cross_origin
  set :allow_origin, :any
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "*"
  200
end

# run OhPerations
run OhPerations::Dispatcher