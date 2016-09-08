# encoding: utf-8

module SlidayBackup
  module Encryptor
    class Base
      include Utilities::Helpers
      include Config::Helpers

      def initialize
        load_defaults!
      end

      private

      ##
      # Return the encryptor name, with SlidayBackup namespace removed
      def encryptor_name
        self.class.to_s.sub('SlidayBackup::', '')
      end

      ##
      # Logs a message to the console and log file to inform
      # the client that SlidayBackup is encrypting the archive
      def log!
        Logger.info "Using #{ encryptor_name } to encrypt the archive."
      end
    end
  end
end
