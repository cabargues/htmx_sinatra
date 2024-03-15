require 'sequel'
require_relative '../domain/payments/models/payment'
require_relative '../domain/payments/services/payments'

namespace :db do
  desc 'Creates the database'
  task :create do
    puts "================================"
    puts "=> CREATING DATABASE"
    DB = Sequel.sqlite(ENV["DATABASE_PATH"])
    puts "==> OK"

    puts "=> DROPPING EXISTING TABLES"
    begin
      DB.run "DROP TABLE payments"
      puts "==> OK"
    rescue
      puts "==> OK (No previous database)"
    end

    puts "=> CREATING TABLES"
    puts "==> Creating table payments"

    DB.create_table :payments do
      primary_key :id
      column :reference, String, null: false, index: true
      column :status, String, null: false, index: true
      column :amount_from, Integer
      column :currency_from, String
      column :amount_to, Integer
      column :currency_to, String
      column :country, String
      column :sender_email, String
      column :sender_name, String
      column :sender_country, String
      column :sender_state, String
      column :sender_address, String
      column :beneficiary_code, String
      column :beneficiary_name, String
      column :beneficiary_account, String
      column :beneficiary_country, String
      column :cancellation_reason, String
      column :created_at, DateTime
      column :received_at, DateTime
      column :verifying_at, DateTime
      column :verified_at, DateTime
      column :delivered_at, DateTime
      column :cancelled_at, DateTime
    end
    puts "==> OK"
    puts "================================"
  end


  desc 'Seeds the databse'
  task :seed do
    puts "================================"
    puts "=> SEEDING DATABASE"

    file = File.read('./payments.json')

    payments = JSON.parse(file, symbolize_names: true)
    puts "==> Adding #{payments.length} payments"

    payments.each do |data|
      Helper.create_payment(data)
    end

    puts "==> OK"
    puts "================================"
  end

  module Helper
    def self.create_payment(data)
      case data[:status]
      when 'pending'
        created_at = data[:created_at]
        received_at = nil
        verifying_at = nil
        verified_at = nil
        delivered_at = nil
        cancelled_at = nil
      when 'received'
        created_at = data[:created_at]
        received_at = data[:received_at]
        verifying_at = nil
        verified_at = nil
        delivered_at = nil
        cancelled_at = nil
      when 'verifying'
        created_at = data[:created_at]
        received_at = data[:received_at]
        verifying_at = data[:received_at]
        verified_at = nil
        delivered_at = nil
        cancelled_at = nil
      when 'verified'
        created_at = data[:created_at]
        received_at = data[:received_at]
        verifying_at = data[:received_at]
        verified_at = data[:received_at]
        delivered_at = nil
        cancelled_at = nil
      when 'delivered'
        created_at = data[:created_at]
        received_at = data[:received_at]
        verifying_at = data[:received_at]
        verified_at = data[:received_at]
        delivered_at = data[:delivered_at]
        cancelled_at = nil
      when 'cancelled'
        created_at = data[:created_at]
        received_at = data[:received_at]
        verifying_at = data[:received_at]
        verified_at = data[:received_at]
        delivered_at = data[:delivered_at]
        cancelled_at = data[:cancelled_at]
      else
        puts "Unknown status"
      end

      payment = Domain::Payments::Models::Payment.parse({
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
        created_at: created_at,
        received_at: received_at,
        verifying_at: verifying_at,
        verified_at: verified_at,
        delivered_at: delivered_at,
        cancelled_at: cancelled_at
      })

      Domain::Payments::Services::Payments.create(payment)
    end
  end
end