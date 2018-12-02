require 'spec_helper'

describe 'nextcloud' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'with default' do
        let(:facts) do
          facts.merge(
            root_home: '/root',
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('nextcloud::database') }
        it { is_expected.to contain_class('nextcloud::php') }
        it { is_expected.to contain_class('nextcloud::install') }
        it { is_expected.to contain_class('nextcloud::webserver') }
        it { is_expected.to contain_class('nextcloud::config') }
      end
    end
  end
end
