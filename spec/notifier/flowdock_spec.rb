# encoding: utf-8

require File.expand_path('../../spec_helper.rb', __FILE__)

module SlidayBackup
  describe Notifier::FlowDock do
    let(:model) { Model.new(:test_trigger, 'test label') }
    let(:notifier) { Notifier::FlowDock.new(model) }
    let(:s) { sequence '' }

    it_behaves_like 'a class that includes Config::Helpers'
    it_behaves_like 'a subclass of Notifier::Base'

    describe '#initialize' do
      it 'provides default values' do
        expect( notifier.token          ).to be_nil
        expect( notifier.from_name      ).to be_nil
        expect( notifier.from_email     ).to be_nil
        expect( notifier.subject        ).to eql 'SlidayBackup Notification'
        expect( notifier.source         ).to  eql 'SlidayBackup test label'

        expect( notifier.on_success     ).to be(true)
        expect( notifier.on_warning     ).to be(true)
        expect( notifier.on_failure     ).to be(true)
        expect( notifier.max_retries    ).to be(10)
        expect( notifier.retry_waitsec  ).to be(30)
      end

      it 'configures the notifier' do
        notifier = Notifier::FlowDock.new(model) do |flowdock|
          flowdock.token           = 'my_token'
          flowdock.from_name       = 'my_name'
          flowdock.from_email      = 'email@example.com'
          flowdock.subject         = 'My Daily SlidayBackup'

          flowdock.on_success    = false
          flowdock.on_warning    = false
          flowdock.on_failure    = false
          flowdock.max_retries   = 5
          flowdock.retry_waitsec = 10
        end

        expect( notifier.token          ).to eq 'my_token'
        expect( notifier.from_name           ).to eq 'my_name'
        expect( notifier.from_email ).to eq 'email@example.com'
        expect( notifier.subject ).to eq 'My Daily SlidayBackup'

        expect( notifier.on_success     ).to be(false)
        expect( notifier.on_warning     ).to be(false)
        expect( notifier.on_failure     ).to be(false)
        expect( notifier.max_retries    ).to be(5)
        expect( notifier.retry_waitsec  ).to be(10)
      end
    end # describe '#initialize'

    describe '#notify!' do
      let(:notifier) {
        Notifier::FlowDock.new(model) do |flowdock|
          flowdock.token           = 'my_token'
          flowdock.from_name       = 'my_name'
          flowdock.from_email      = 'email@example.com'
          flowdock.subject         = 'My Daily SlidayBackup'
          flowdock.tags            = ['prod']
          flowdock.link            = 'www.example.com'
        end
      }
      let(:client) { mock }
      let(:push_to_team_inbox) { mock }
      let(:message) { '[SlidayBackup::%s] test label (test_trigger)' }

      context 'when status is :success' do
        it 'sends a success message' do
          Flowdock::Flow.expects(:new).in_sequence(s).
              with(:api_token => 'my_token', :source => 'SlidayBackup test label',
                    :from => {:name => 'my_name', :address => 'email@example.com'}
                    ).returns(client)
          client.expects(:push_to_team_inbox).in_sequence(s).
              with(:subject => 'My Daily SlidayBackup',
                   :content => message % 'Success',
                   :tags => [ 'prod', '#SlidayBackupSuccess' ],
                   :link => 'www.example.com' )

          notifier.send(:notify!, :success)
        end
      end

      context 'when status is :warning' do
        it 'sends a warning message' do
          Flowdock::Flow.expects(:new).in_sequence(s).
              with(:api_token => 'my_token', :source => 'SlidayBackup test label',
                    :from => {:name => 'my_name', :address => 'email@example.com'}
                    ).returns(client)
          client.expects(:push_to_team_inbox).in_sequence(s).
              with(:subject => 'My Daily SlidayBackup',
                   :content => message % 'Warning',
                   :tags => [ 'prod', '#SlidayBackupWarning' ],
                   :link => 'www.example.com' )

          notifier.send(:notify!, :warning)
        end
      end

      context 'when status is :failure' do
        it 'sends a failure message' do
          Flowdock::Flow.expects(:new).in_sequence(s).
              with(:api_token => 'my_token', :source => 'SlidayBackup test label',
                    :from => {:name => 'my_name', :address => 'email@example.com'}
                    ).returns(client)
          client.expects(:push_to_team_inbox).in_sequence(s).
              with(:subject => 'My Daily SlidayBackup',
                   :content => message % 'Failure',
                   :tags => [ 'prod', '#SlidayBackupFailure' ],
                   :link => 'www.example.com' )

          notifier.send(:notify!, :failure)
        end
      end

    end
  end
end
