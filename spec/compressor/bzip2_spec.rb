# encoding: utf-8

require File.expand_path('../../spec_helper.rb', __FILE__)

describe SlidayBackup::Compressor::Bzip2 do
  before do
    SlidayBackup::Compressor::Bzip2.any_instance.stubs(:utility).returns('bzip2')
  end

  it 'should be a subclass of Compressor::Base' do
    SlidayBackup::Compressor::Bzip2.
      superclass.should == SlidayBackup::Compressor::Base
  end

  describe '#initialize' do
    let(:compressor) { SlidayBackup::Compressor::Bzip2.new }

    after { SlidayBackup::Compressor::Bzip2.clear_defaults! }

    it 'should load pre-configured defaults' do
      SlidayBackup::Compressor::Bzip2.any_instance.expects(:load_defaults!)
      compressor
    end

    context 'when no pre-configured defaults have been set' do
      it 'should use default values' do
        compressor.level.should be_false

        compressor.instance_variable_get(:@cmd).should == 'bzip2'
        compressor.instance_variable_get(:@ext).should == '.bz2'
      end

      it 'should use the values given' do
        compressor = SlidayBackup::Compressor::Bzip2.new do |c|
          c.level = 5
        end
        compressor.level.should == 5

        compressor.instance_variable_get(:@cmd).should == 'bzip2 -5'
        compressor.instance_variable_get(:@ext).should == '.bz2'
      end
    end # context 'when no pre-configured defaults have been set'

    context 'when pre-configured defaults have been set' do
      before do
        SlidayBackup::Compressor::Bzip2.defaults do |c|
          c.level = 7
        end
      end

      it 'should use pre-configured defaults' do
        compressor.level.should == 7

        compressor.instance_variable_get(:@cmd).should == 'bzip2 -7'
        compressor.instance_variable_get(:@ext).should == '.bz2'
      end

      it 'should override pre-configured defaults' do
        compressor = SlidayBackup::Compressor::Bzip2.new do |c|
          c.level = 6
        end
        compressor.level.should == 6

        compressor.instance_variable_get(:@cmd).should == 'bzip2 -6'
        compressor.instance_variable_get(:@ext).should == '.bz2'
      end
    end # context 'when pre-configured defaults have been set'
  end # describe '#initialize'

end
