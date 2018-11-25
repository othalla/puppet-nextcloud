require 'spec_helper'

describe 'nextcloud' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'without ssl' do
        let(:facts) do
          facts.merge(
            root_home: '/root',
          )
        end
        let :params do
          {
            ssl: false,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('nextcloud::database') }
      end
    end
  end
end
