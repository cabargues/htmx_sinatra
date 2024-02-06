require 'sinatra'
require_relative '../domain/payments/services/payments'

module Api
  class PaymentsController < Sinatra::Base
    get '/' do
      payments = get_payment_list(params['status'])

      payments_list = payments.map do |payment|
        payment.to_h
      end

      erb :_payments, { locals: {  payments: payments_list } }
    end

    private

    def get_payment_list(status)
      unless status.nil? || status.empty?
        Domain::Payments::Services::Payments.fetch_all_by_status(status)
      else
        Domain::Payments::Services::Payments.fetch_all()
      end
    end

    def get_payment(reference)
      Domain::Payments::Services::Payments.fetch_by_reference(reference)
    end
  end
end