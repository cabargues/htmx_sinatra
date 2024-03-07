require 'sinatra'

module Api
  module Controllers
    class Base < Sinatra::Base
      set :views, File.expand_path('../../../views', __FILE__)
      set :public_folder, File.expand_path('../../../public', __FILE__)
    end
  end
end