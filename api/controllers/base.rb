require 'sinatra'

module Api
  module Controllers
    class Base < Sinatra::Base
      set :views, File.expand_path('../../../views', __FILE__)
      set :public_folder, File.expand_path('../../../public', __FILE__)

      not_found do
        erb :_not_found, :layout => :app_layout
      end
    end
  end
end