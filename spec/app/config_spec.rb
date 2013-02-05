require 'spec_helper'

describe 'Configuration tests' do
  it 'should load configus' do
    configus.should_not be_nil
  end
  
  it 'should have dropbox settings' do
    configus.dropbox_app_key.should_not be_nil
  end
  
  it 'should have values hash' do
    Configus.config.should_not be_nil
    Configus.config[:dropbox_app_key].should_not be_nil
  end
end