require 'spec_helper'

describe SimpleMattermost::Client do
  let(:client) { SimpleMattermost::Client.new }
  describe '#login' do
    context 'success' do
      it 'return 200 status' do
        expect(client.login.status).to eq 200
      end
    end
  end
end
