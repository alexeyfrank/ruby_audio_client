require 'spec_helper'

describe 'Application tests' do
  it 'should have constant method self.base_path' do
    AudioClient::Application.should respond_to :base_path
    AudioClient::Application.base_path.should_not be_nil
  end
end