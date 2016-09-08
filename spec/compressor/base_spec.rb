# encoding: utf-8

require File.expand_path('../../spec_helper.rb', __FILE__)

describe SlidayBackup::Compressor::Base do
  let(:compressor) { SlidayBackup::Compressor::Base.new }

  it 'should include Utilities::Helpers' do
    SlidayBackup::Compressor::Base.
        include?(SlidayBackup::Utilities::Helpers).should be_true
  end

  it 'should include Config::Helpers' do
    SlidayBackup::Compressor::Base.
        include?(SlidayBackup::Config::Helpers).should be_true
  end

  describe '#compress_with' do
    it 'should yield the compressor command and extension' do
      compressor.instance_variable_set(:@cmd, 'compressor command')
      compressor.instance_variable_set(:@ext, 'compressor extension')

      compressor.expects(:log!)

      compressor.compress_with do |cmd, ext|
        cmd.should == 'compressor command'
        ext.should == 'compressor extension'
      end
    end
  end

  describe '#compressor_name' do
    it 'should return class name with SlidayBackup namespace removed' do
      compressor.send(:compressor_name).should == 'Compressor::Base'
    end
  end

  describe '#log!' do
    it 'should log a message' do
      compressor.instance_variable_set(:@cmd, 'compressor command')
      compressor.instance_variable_set(:@ext, 'compressor extension')
      compressor.expects(:compressor_name).returns('Compressor Name')

      SlidayBackup::Logger.expects(:info).with(
        "Using Compressor Name for compression.\n" +
        "  Command: 'compressor command'\n" +
        "  Ext: 'compressor extension'"
      )
      compressor.send(:log!)
    end
  end
end
