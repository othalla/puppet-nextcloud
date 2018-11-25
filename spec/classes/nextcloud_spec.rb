require 'spec_helper'

describe 'nextcloud' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :params do
        {
          ssl: false,
        }
      end
      let(:facts) do
        facts.merge({
          root_home: '/root',
        })
      end

      describe 'with default' do

        it { is_expected.to contain_class('nextcloud::database') }
      end
    end
  end
end
