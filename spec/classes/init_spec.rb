require 'spec_helper'
describe 'nextcloud' do
  context 'with default values for all parameters' do
    it { should contain_class('nextcloud') }
  end
end
