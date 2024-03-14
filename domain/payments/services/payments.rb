require_relative '../repositories/payments'

module Domain
  module Payments
    module Services
      class Payments
        class << self
          def fetch_by_reference(payment_reference)
            Repositories::Payments.fetch_by_reference(payment_reference)
          end

          def fetch_all_by_status(status)
            Repositories::Payments.fetch_all_by_status(status)
          end

          def create(payment)
            Repositories::Payments.create(payment)
          end

          def search(criteria)
            Repositories::Payments.search(criteria)
          end

          def count_all_by_status(status)
            Repositories::Payments.count_all_by_status(status)
          end
        end
      end
    end
  end
end
