# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mirco, type: :model do
  context ' with empty Settings' do
    before(:each) do
      allow(Mirco::CONFIG).to receive(:[]).with('devise_modules').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('mail_from').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('use_ssl').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('host').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('port').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('script_name').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('mail_to').and_return(nil)

      allow(Mirco::CONFIG).to receive(:[]).with('remote_user').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('action_cable_allowed_request_origins').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_statistics').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_channels').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_configuration').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('cron_purge_timescale').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('warning_period').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('queued_warning_level').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('queued_critical_level').and_return(nil)
    end
    it {
      expect(Mirco.devise_modules).to contain_exactly(
        :remote_user_authenticatable,
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :trackable
      )
    }
    it { expect(Mirco.host).to eq('localhost') }
    it { expect(Mirco.port).to eq(nil) }
    it { expect(Mirco.script_name).to eq('/') }
    it { expect(Mirco.mail_from).to eq('root') }
    it { expect(Mirco.use_ssl).to be_falsey }
    it { expect(Mirco.remote_user).to eq('REMOTE_USER') }
    it { expect(Mirco.mail_to).to eq([]) }
    it {
      expect(Mirco.action_cable_allowed_request_origins).to contain_exactly(
        'http://localhost', 'https://localhost'
      )
    }
    it { expect(Mirco.cron_fetch_statistics).to eq('*/5 * * * *') }
    it { expect(Mirco.cron_fetch_channels).to eq('0 1 * * 6') }
    it { expect(Mirco.cron_fetch_configuration).to eq('15 1 * * 6') }
    it { expect(Mirco.cron_purge_timescale).to eq('30 1 * * 6') }
    it { expect(Mirco.warning_period).to eq(10) }
    it { expect(Mirco.queued_warning_level).to eq(10) }
    it { expect(Mirco.queued_critical_level).to eq(50) }
  end

  context ' with existing Settings' do
    before(:each) do
      allow(Mirco::CONFIG).to receive(:[]).with('devise_modules').and_return([:brabbel])
      allow(Mirco::CONFIG).to receive(:[]).with('mail_from').and_return('from@example.org')
      allow(Mirco::CONFIG).to receive(:[]).with('use_ssl').and_return(true)
      allow(Mirco::CONFIG).to receive(:[]).with('host').and_return('myhost')
      allow(Mirco::CONFIG).to receive(:[]).with('port').and_return(3031)
      allow(Mirco::CONFIG).to receive(:[]).with('script_name').and_return('/water')
      allow(Mirco::CONFIG).to receive(:[]).with('mail_to').and_return(['somebody@example.net'])

      allow(Mirco::CONFIG).to receive(:[]).with('remote_user').and_return('OTHER_USER')
      allow(Mirco::CONFIG).to receive(:[]).with('action_cable_allowed_request_origins').and_return(['http://otherwise'])
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_statistics').and_return('* * nix')
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_channels').and_return('* * nix')
      allow(Mirco::CONFIG).to receive(:[]).with('cron_fetch_configuration').and_return('* * nix')
      allow(Mirco::CONFIG).to receive(:[]).with('cron_purge_timescale').and_return('* * nix')
      allow(Mirco::CONFIG).to receive(:[]).with('warning_period').and_return(23)
      allow(Mirco::CONFIG).to receive(:[]).with('queued_warning_level').and_return(47)
      allow(Mirco::CONFIG).to receive(:[]).with('queued_critical_level').and_return(71)
    end
    it { expect(Mirco.devise_modules).to contain_exactly(:brabbel) }
    it { expect(Mirco.host).to eq('myhost') }
    it { expect(Mirco.port).to eq(3031) }
    it { expect(Mirco.script_name).to eq('/water') }
    it { expect(Mirco.mail_from).to eq('from@example.org') }
    it { expect(Mirco.use_ssl).to be_truthy }
    it { expect(Mirco.remote_user).to eq('OTHER_USER') }
    it { expect(Mirco.mail_to).to eq(['somebody@example.net']) }
    it {
      expect(Mirco.action_cable_allowed_request_origins).to contain_exactly(
        'http://otherwise'
      )
    }
    it { expect(Mirco.cron_fetch_statistics).to eq('* * nix') }
    it { expect(Mirco.cron_fetch_channels).to eq('* * nix') }
    it { expect(Mirco.cron_fetch_configuration).to eq('* * nix') }
    it { expect(Mirco.cron_purge_timescale).to eq('* * nix') }
    it { expect(Mirco.warning_period).to eq(23) }
    it { expect(Mirco.queued_warning_level).to eq(47) }
    it { expect(Mirco.queued_critical_level).to eq(71) }
  end

  describe '::ldap_options' do
    context ' with empty Settings' do
      before(:each) do
        allow(Mirco::CONFIG).to receive(:[]).with('ldap_options').and_return(nil)
      end
      it { expect(Mirco.ldap_options).to be_nil }
    end

    context ' with existing Settings' do
      let(:ldap_options) do
        {
          'host' => '192.0.2.71',
          'port' => 3268,
          'base' => 'dc=example,dc=com',
          'auth' => {
            'method' => :simple,
            'username' => 'myldapuser',
            'password' => 'myldappasswd'
          }
        }
      end
      let(:ldap_options_ary) do
        [{
          'host' => '192.0.2.71',
          'port' => 3268,
          'base' => 'dc=example,dc=com',
          'auth' => {
            'method' => :simple,
            'username' => 'myldapuser',
            'password' => 'myldappasswd'
          }
        }]
      end
      let(:ldap_options_sym) do
        [{
          host: '192.0.2.71',
          port: 3268,
          base: 'dc=example,dc=com',
          auth: {
            method: :simple,
            username: 'myldapuser',
            password: 'myldappasswd'
          }
        }]
      end
      it 'returns symbolized keys from Hash' do
        allow(Mirco::CONFIG).to receive(:[]).with('ldap_options')
                                            .and_return(ldap_options)
        expect(Mirco.ldap_options).to eq(ldap_options_sym)
      end
      it 'returns symbolized keys from Array of Hashes' do
        allow(Mirco::CONFIG).to receive(:[]).with('ldap_options')
                                            .and_return(ldap_options_ary)
        expect(Mirco.ldap_options).to eq(ldap_options_sym)
      end
    end
  end
  describe "routes.default_url_options" do
    # Routes default url options has to be set in local configuration file mirco.yml
    it "sets default_url_options" do
      expect(Rails.application.routes.default_url_options).to include(
             host: 'dev.local', port: 3001, script_name: '/')
    end
  end

  describe "#timescale_license" do
    it { expect(Mirco::timescale_license).to be_kind_of(String) }
    it { expect(Mirco::timescale_license).to match(/apache|timescale/) }
  end
end
