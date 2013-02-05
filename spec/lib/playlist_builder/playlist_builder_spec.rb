require 'spec_helper'

describe 'PlaylistBuilder' do
  it 'should have build method' do
    AudioClient::PlaylistBuilder.should respond_to :build
  end
end