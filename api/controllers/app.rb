require 'sinatra'
require_relative './base'

module Api
  module Controllers
    class App < Base
      get '/' do
        erb :index, :layout => :app_layout
      end
    end
  end
end