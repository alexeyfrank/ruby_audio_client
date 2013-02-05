require 'spec_helper'

describe 'FileUpdater specs' do
  it 'should have method start' do
    AudioClient::FileUpdater.should respond_to :start
  end  
  
  it 'should have activesupport methods' do
    4.should respond_to :hours
  end
end