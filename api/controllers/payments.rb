require 'sinatra'
require_relative './base'
require_relative '../../domain/payments/services/payments'

module Api
  module Controllers
    class Payments < Base
      get '/' do
        status = params['status']

        erb :app_layout do
          erb :_payments, {locals: { status: status }} # do
        end
      end

      get '/list' do
        sleep(rand(2.0))
        status = params['status']
        payments = get_payments_list_by(status)

        payments_list = payments.map do |payment|
          payment.to_h
        end

        erb :_payments_list, { locals: { payments: payments_list } }, :layout => false
      end

      get '/count' do
        sleep(rand(2.0))
        status = params['status']
        payments_count = get_payments_count_by(status)

        erb :_pooler, { locals: { count: payments_count, status: status } }, :layout => false
      end

      get '/:reference' do
        payment_details = get_payment(params["reference"])

        erb :_payment_details, { locals: payment_details.to_h  }, :layout => false
      end

      post '/search' do
        criteria = {
          search: params['search'],
          status: params['status']
        }
        payments = search_payment_list(criteria)


        payments_list = payments.map do |payment|
          payment.to_h
        end

        erb :_payments_list, { locals: { payments: payments_list } }
      end

      private

      def get_payments_list_by(status)
        Domain::Payments::Services::Payments.fetch_all_by_status(status)
      end

      def get_payment(reference)
        Domain::Payments::Services::Payments.fetch_by_reference(reference)
      end

      def search_payment_list(criteria)
        Domain::Payments::Services::Payments.search(criteria)
      end

      def get_payments_count_by(status)
        Domain::Payments::Services::Payments.count_all_by_status(status)
      end
    end
  end
end

