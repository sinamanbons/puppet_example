require 'spec_helper'
describe 'puppet_node' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppet_node') }
  end
end
