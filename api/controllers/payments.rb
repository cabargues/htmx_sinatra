require 'sinatra'
require_relative './base'
require_relative '../../domain/payments/services/payments'

module Api
  module Controllers
    class Payments < Base
      get '/' do
        payments = get_payment_list(params['status'])

        payments_list = payments.map do |payment|
          payment.to_h
        end

        erb :_payments, { locals: { payments: payments_list } }
      end

      post '/search' do
        payments = search_payment_list(params['search'])

        payments_list = payments.map do |payment|
          payment.to_h
        end

        erb :_payments, { locals: { payments: payments_list } }
      end

      private

      def get_payment_list(status)
        if status.nil? || status.empty?
          Domain::Payments::Services::Payments.fetch_all
        else
          Domain::Payments::Services::Payments.fetch_all_by_status(status)
        end
      end

      def get_payment(reference)
        Domain::Payments::Services::Payments.fetch_by_reference(reference)
      end

      def search_payment_list(search)
        Domain::Payments::Services::Payments.search(search)
      end
    end
  end
end

