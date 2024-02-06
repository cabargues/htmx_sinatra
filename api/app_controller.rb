require 'sinatra'

module Api
  class AppController < Sinatra::Base
    get '/' do
      erb :index
    end
  end
end