# encoding: utf-8

require File.expand_path('../../spec_helper.rb', __FILE__)

describe SlidayBackup::Encryptor::Base do
  let(:base) { SlidayBackup::Encryptor::Base.new }

  it 'should include Utilities::Helpers' do
    SlidayBackup::Encryptor::Base.
      include?(SlidayBackup::Utilities::Helpers).should be_true
  end

  it 'should include Config::Helpers' do
    SlidayBackup::Encryptor::Base.
      include?(SlidayBackup::Config::Helpers).should be_true
  end

  describe '#initialize' do
    it 'should load defaults' do
      SlidayBackup::Encryptor::Base.any_instance.expects(:load_defaults!)
      base
    end
  end

  describe '#encryptor_name' do
    it 'should return class name with SlidayBackup namespace removed' do
      base.send(:encryptor_name).should == 'Encryptor::Base'
    end
  end

  describe '#log!' do
    it 'should log a message' do
      base.expects(:encryptor_name).returns('Encryptor Name')
      SlidayBackup::Logger.expects(:info).with(
        'Using Encryptor Name to encrypt the archive.'
      )
      base.send(:log!)
    end
  end
end
