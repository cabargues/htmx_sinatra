require 'sinatra'
require './infrastructure/dblite'
require './api/controllers/app'
require './api/controllers/payments'

module OhPerations
  Dispatcher = Rack::Builder.app do
    map '/payments' do
      run Api::Controllers::Payments
    end

    map '/' do
      run Api::Controllers::App
    end
  end
end


