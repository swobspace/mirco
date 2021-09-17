require 'rails_helper'

RSpec.describe ChannelDecorator do
  let(:ch)    { channel.decorate }
  let(:properties) {{
    "sourceConnector": {
      "transportName": "rheinschipper",
    }
  }}

  describe "with properties set" do
    let(:channel) { FactoryBot.create(:channel, properties: properties) }
    it { expect(ch.sc_transport_name).to eq("rheinschipper") }
  end

  describe "with empty properties" do
    let(:channel) { FactoryBot.create(:channel)}
  end

  
end

