# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'
require 'sliday_backup'

require 'timecop'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f }

module SlidayBackup::ExampleHelpers
  # ripped from MiniTest :)
  # RSpec doesn't have a method for this? Am I missing something?
  def capture_io
    require 'stringio'

    orig_stdout, orig_stderr = $stdout, $stderr
    captured_stdout, captured_stderr = StringIO.new, StringIO.new
    $stdout, $stderr = captured_stdout, captured_stderr

    yield

    return captured_stdout.string, captured_stderr.string
  ensure
    $stdout = orig_stdout
    $stderr = orig_stderr
  end
end

require 'rspec/autorun'
RSpec.configure do |config|
  ##
  # Use Mocha to mock with RSpec
  config.mock_with :mocha

  ##
  # Example Helpers
  config.include SlidayBackup::ExampleHelpers

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before(:suite) do
    # Initializes SandboxFileUtils so the first call to deactivate!(:noop)
    # will set ::FileUtils to FileUtils::NoWrite
    SandboxFileUtils.activate!
  end

  config.before(:each) do
    # ::FileUtils will always be either SandboxFileUtils or FileUtils::NoWrite.
    SandboxFileUtils.deactivate!(:noop)

    # prevent system calls
    SlidayBackup::Utilities.stubs(:gnu_tar?).returns(true)
    SlidayBackup::Utilities.stubs(:utility)
    SlidayBackup::Utilities.stubs(:run)
    SlidayBackup::Pipeline.any_instance.stubs(:run)

    SlidayBackup::Utilities.send(:reset!)
    SlidayBackup::Config.send(:reset!)
    # Logger only queues messages received until Logger.start! is called.
    SlidayBackup::Logger.send(:reset!)
  end
end

puts "\nRuby version: #{ RUBY_DESCRIPTION }\n\n"
