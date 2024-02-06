require 'sequel'
require 'logger'

Sequel.default_timezone = :utc

module Infrastructure
  class DBLite
    def self.client
      return @client if defined? @client

      @client = Sequel.sqlite('database.db', loggers: [Logger.new($stodout)])
    end
  end
end