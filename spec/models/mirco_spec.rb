require 'rails_helper'

RSpec.describe Mirco, type: :model do
  context ' with empty Settings' do
    before(:each) do
      allow(Mirco::CONFIG).to receive(:[]).with('devise_modules').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('mail_from').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('use_ssl').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('host').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('script_name').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('mail_to').and_return(nil)

      allow(Mirco::CONFIG).to receive(:[]).with('remote_user').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('action_cable_allowed_request_origins').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('cron_expression').and_return(nil)
      allow(Mirco::CONFIG).to receive(:[]).with('warn_threshold').and_return(nil)
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
    it { expect(Mirco.cron_expression).to eq('*/5 * * * *') }
    it { expect(Mirco.warn_threshold).to eq(10) }
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
end
