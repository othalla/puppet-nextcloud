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

      describe 'with db_managed false' do
        let(:facts) do
          facts.merge(
            root_home: '/root',
          )
        end

        let :params do
          {
            db_managed: false,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('nextcloud::php') }
        it { is_expected.to contain_class('nextcloud::install') }
        it { is_expected.to contain_class('nextcloud::webserver') }
        it { is_expected.to contain_class('nextcloud::config') }
      end

      describe 'with ssl true' do
        let(:facts) do
          facts.merge(
            root_home: '/root',
          )
        end
        context 'should fail without ssl_cert_file and ssl_key_file' do
          let :params do
            {
              ssl: true,
            }
          end

          it { is_expected.to compile.and_raise_error(/You must provide certificate/) }
        end
      end
    end
  end
end
