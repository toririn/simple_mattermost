require 'spec_helper'

describe SimpleMattermost::Hook do
  let(:hook) { SimpleMattermost::Hook.new }
  describe '#post' do
    context 'success' do
      it 'return true' do
        expect(hook.post("test")).to eq true
      end
    end
  end
end
