require 'sequel'
require_relative '../../../infrastructure/dblite'
require_relative '../models/payment'

module Domain
  module Payments
    module Repositories
      class Payments
        class << self
          def fetch_all()
            result = dataset.all
            return unless result

            parse_payments(result)
          end

          def fetch_by_reference(payment_reference)
            result = dataset.first(reference: payment_reference)
            return unless result

            parse_payment(result)
          end

          def fetch_all_by_status(status)
            if status.nil? || status.empty?
              result = dataset.all
            else
              result = dataset.where(status: status).order(:created_at)
            end
            return unless result

            parse_payments(result)
          end

          def search(criteria)
            search_term = criteria[:search]
            status = criteria[:status]

            unless status.nil? || status.empty?
              result = dataset.where(
                Sequel[status: status] & (
                  (Sequel.ilike(:reference, "%#{search_term}%")) |
                  (Sequel.ilike(:sender_email, "%#{search_term}%")) |
                  (Sequel.ilike(:sender_name, "%#{search_term}%")) |
                  (Sequel.ilike(:sender_country, "%#{search_term}%")) |
                  (Sequel.ilike(:beneficiary_name, "%#{search_term}%"))
                  )
                ).order(:created_at)
            else
              result = dataset.where(
                Sequel.ilike(:reference, "%#{search_term}%"))
                .or(Sequel.ilike(:sender_email, "%#{search_term}%"))
                .or(Sequel.ilike(:sender_name, "%#{search_term}%"))
                .or(Sequel.ilike(:sender_country, "%#{search_term}%"))
                .or(Sequel.ilike(:beneficiary_name, "%#{search_term}%"))
                .order(:created_at)
            end



            return unless result

            parse_payments(result)
          end

          def create(payment)
            dataset.insert(payment.to_h)

            fetch_by_reference(payment.reference)
          end


          def count_all_by_status(status)
            if status.nil? || status.empty?
              result = dataset.all.count
            else
              result = dataset.where(status: status).count
            end
          end


          # def update(payment)
          #   # TODO:
          # end

          private

          def to_h(payment)
            {
              reference: payment.reference,
              status: payment.status,
              amount_from: payment.amount_from,
              currency_from: payment.currency_from,
              amount_to: payment.amount_to,
              currency_to: payment.currency_to,
              country: payment.country,
              sender_email: payment.sender_email,
              sender_name: payment.sender_name,
              sender_country: payment.sender_country,
              sender_state: payment.sender_state,
              sender_address: payment.sender_address,
              beneficiary_code: payment.beneficiary_code,
              beneficiary_name: payment.beneficiary_name,
              beneficiary_account: payment.beneficiary_account,
              beneficiary_country: payment.beneficiary_country,
              cancellation_reason: payment.cancellation_reason,
              created_at: payment.created_at,
              received_at: payment.received_at,
              verifying_at: payment.verifying_at,
              verified_at: payment.verified_at,
              delivered_at: payment.delivered_at,
              cancelled_at: payment.cancelled_at
            }
          end

          def parse_payment(data)
            Domain::Payments::Models::Payment.parse(data)
          end

          def parse_payments(data)
            data.map do |row|
              Domain::Payments::Models::Payment.parse(row)
            end
          end

          def dataset
            storage[:payments]
          end

          def storage
            Infrastructure::DBLite.client
          end
        end
      end
    end
  end
end