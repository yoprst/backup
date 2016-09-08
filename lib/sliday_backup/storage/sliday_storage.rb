# encoding: utf-8
require "net/http"
require "uri"
require 'json'

module SlidayBackup
  module Storage
    class SlidayStorage < Base
      include Storage::Cycler
      class Error < SlidayBackup::Error;
      end

      attr_accessor :api_key
      attr_accessor :backup_host

      def initialize(model, storage_id = nil)
        super
        @backup_host ||= 'https://sliday-backups.herokuapp.com'
      end

      private

      def transfer!
        uri = URI.parse("#{@backup_host}/api/#{@api_key}")
        response = Net::HTTP.post_form(uri, {})
        if response.code != "200"
          raise Error.wrap(Exception.new, 'Authorization Failed')
        end
        backup = JSON.parse(response.body)
        upload_url = URI.parse(backup['upload_url'])
        package.filenames.each do |filename|
          src = File.join(Config.tmp_path, filename)
          Net::HTTP.start(upload_url.host) do |http|
            http.send_request("PUT", upload_url.request_uri, File.read(src), {
                "content-type" => "",
            })
          end
          Logger.info "Uploading..."
        end
        finalize_uri = URI.parse("#{@backup_host}/api/#{@api_key}/#{backup['id']}/finish")
        Net::HTTP.post_form(finalize_uri, {})
      end

      # Called by the Cycler.
      # Any error raised will be logged as a warning.
      def remove!(package)
        Logger.info "Removing backup package dated #{ package.time }..."

        FileUtils.rm_r(remote_path_for(package))
      end

      # expanded since this is a local path
      def remote_path(pkg = package)
        File.expand_path(super)
      end

      alias :remote_path_for :remote_path

      ##
      # If this Local Storage is not the last Storage for the Model,
      # force the transfer to use a *copy* operation and issue a warning.
      def package_movable?
        if self == model.storages.last
          true
        else
          Logger.warn Error.new(<<-EOS)
            Local File Copy Warning!
            The final backup file(s) for '#{ model.label }' (#{ model.trigger })
            will be *copied* to '#{ remote_path }'
            To avoid this, when using more than one Storage, the 'Local' Storage
            should be added *last* so the files may be *moved* to their destination.
          EOS
          false
        end
      end

    end
  end
end
