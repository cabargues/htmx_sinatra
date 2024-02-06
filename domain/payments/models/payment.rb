require 'json'

module Domain
  module Payments
    module Models
      class Payment
        PAYMENT_PENDING_STATUS = 'pending'.freeze
        PAYMENT_RECEIVED_STATUS = 'received'.freeze
        PAYMENT_DELIVED_STATUS = 'delivered'.freeze
        PAYMENT_VERIFYING_STATUS = 'verifying'.freeze
        PAYMENT_VERIFIED_STATUS = 'verified'.freeze
        PAYMENT_CANCELLED_STATUS = 'cancelled'.freeze

        attr_accessor :reference
        attr_accessor :status
        attr_accessor :amount_from
        attr_accessor :currency_from
        attr_accessor :amount_to
        attr_accessor :currency_to
        attr_accessor :country
        attr_accessor :sender_email
        attr_accessor :sender_name
        attr_accessor :sender_country
        attr_accessor :sender_state
        attr_accessor :sender_address
        attr_accessor :beneficiary_code
        attr_accessor :beneficiary_name
        attr_accessor :beneficiary_account
        attr_accessor :beneficiary_country
        attr_accessor :cancellation_reason
        attr_accessor :created_at
        attr_accessor :delivered_at
        attr_accessor :received_at
        attr_accessor :cancelled_at

        def initialize(attrs = {})
          @reference = attrs[:reference]
          @status = attrs[:status]
          @amount_from = attrs[:amount_from].to_i
          @currency_from = attrs[:currency_from]
          @amount_to = attrs[:amount_to].to_i
          @currency_to = attrs[:currency_to]
          @country = attrs[:country]
          @sender_email = attrs[:sender_email]
          @sender_name = attrs[:sender_name]
          @sender_country = attrs[:sender_country]
          @sender_state = attrs[:sender_state]
          @sender_address = attrs[:sender_address]
          @beneficiary_code = attrs[:beneficiary_code]
          @beneficiary_name = attrs[:beneficiary_name]
          @beneficiary_account = attrs[:beneficiary_account]
          @beneficiary_country = attrs[:beneficiary_country]
          @cancellation_reason = attrs[:cancellation_reason]
          @created_at = attrs[:created_at]
          @delivered_at = attrs[:delivered_at]
          @received_at = attrs[:received_at]
          @cancelled_at = attrs[:cancelled_at]
        end

        def to_h()
          hash = Hash.new
          self.instance_variables.each do |v|
            hash[v.to_s.delete("@")] = self.instance_variable_get(v)
          end

          hash
        end

        class << self
          def create(payload)
            new(
              reference: payload.reference,
              status: payload.status,
              amount_from: payload.amount_from,
              currency_from: payload.currency_from,
              amount_to: payload.amount_to,
              currency_to: payload.currency_to,
              country: payload.country,
              sender_email: payload.sender_email,
              sender_name: payload.sender_name,
              sender_country: payload.sender_country,
              sender_state: payload.sender_state,
              sender_address: payload.sender_address,
              beneficiary_code: payload.beneficiary_code,
              beneficiary_name: payload.beneficiary_name,
              beneficiary_account: payload.beneficiary_account,
              beneficiary_country: payload.beneficiary_country,
              cancellation_reason: payload.cancellation_reason,
              created_at: payload.created_at,
              delivered_at: payload.delivered_at,
              received_at: payload.received_at,
              cancelled_at: payload.cancelled_at
            )
          end

          def parse(payload)
            data = JSON.parse(JSON.dump(payload), :symbolize_names => true)

            new(
              reference: data[:reference],
              status: data[:status],
              amount_from: data[:amount_from].to_i,
              currency_from: data[:currency_from],
              amount_to: data[:amount_to].to_i,
              currency_to: data[:currency_to],
              country: data[:country],
              sender_email: data[:sender_email],
              sender_name: data[:sender_name],
              sender_country: data[:sender_country],
              sender_state: data[:sender_state],
              sender_address: data[:sender_address],
              beneficiary_code: data[:beneficiary_code],
              beneficiary_name: data[:beneficiary_name],
              beneficiary_account: data[:beneficiary_account],
              beneficiary_country: data[:beneficiary_country],
              cancellation_reason: data[:cancellation_reason],
              created_at: data[:created_at],
              delivered_at: data[:delivered_at],
              received_at: data[:received_at],
              cancelled_at: data[:cancelled_at]
            )
          end
        end
      end
    end
  end
end