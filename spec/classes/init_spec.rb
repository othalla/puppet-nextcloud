require 'spec_helper'
describe 'nextcloud' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('nextcloud') }
  end
end
