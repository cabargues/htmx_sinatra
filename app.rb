require 'sinatra'
require './infrastructure/dblite'
require './api/app_controller'
require './api/payments_controller'

module OhPerations
  Dispatcher = Rack::Builder.app do

    map '/payments' do
      run Api::PaymentsController
    end

    map '/' do
      run Api::AppController
    end
  end
end


