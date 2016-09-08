# encoding: utf-8

module SlidayBackup
  module Compressor
    class Base
      include Utilities::Helpers
      include Config::Helpers

      ##
      # Yields to the block the compressor command and filename extension.
      def compress_with
        log!
        yield @cmd, @ext
      end

      private

      ##
      # Return the compressor name, with SlidayBackup namespace removed
      def compressor_name
        self.class.to_s.sub('SlidayBackup::', '')
      end

      ##
      # Logs a message to the console and log file to inform
      # the client that SlidayBackup is using the compressor
      def log!
        Logger.info "Using #{ compressor_name } for compression.\n" +
          "  Command: '#{ @cmd }'\n" +
          "  Ext: '#{ @ext }'"
      end

    end
  end
end
