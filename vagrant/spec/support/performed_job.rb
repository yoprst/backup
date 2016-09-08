# encoding: utf-8

module SlidayBackupSpec
  class PerformedJob
    attr_reader :model, :logger, :package
    def initialize(model)
      @model = model
      @logger = SlidayBackup::Logger.saved.shift
      @package = Package.new(model)
    end
  end
end
