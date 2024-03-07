require 'sequel'
require 'logger'

Sequel.default_timezone = :utc

module Infrastructure
  class DBLite
    def self.client
      return @client if defined? @client

      @client = Sequel.sqlite(ENV["DATABASE_PATH"], loggers: [Logger.new($stodout)])
    end
  end
end