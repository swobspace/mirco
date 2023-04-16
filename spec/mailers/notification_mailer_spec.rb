require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  include ActionView::Helpers::SanitizeHelper
  let(:server) { FactoryBot.create(:server, name: "xyzmirth") }
  let!(:channel) { FactoryBot.create(:channel, server: server, properties: {name: "MyChannel"}) }
  let!(:channel_statistic) do
    FactoryBot.create(:channel_statistic, server: server,
                                          channel: channel,
                                          name: "DestoConnecto")
  end
  let(:alert) { FactoryBot.create(:alert, server: server,
                                          channel: channel,
                                          channel_statistic: channel_statistic,
                                          type: 'ok',
                                          message: "Lorem ipsum dolor sit amet") }
  let(:mail) { NotificationMailer.with(alert: alert).alert }

  it "renders the header" do
    expect(Mirco).to receive(:mail_from).and_return('from@example.org')
    expect(Mirco).to receive(:mail_to).and_return(['operator@example.org', 'chief@example.org'])

    expect(mail.subject).to eq("Ok for #{alert.alertable.fullname}")
    expect(mail.from).to eq(["from@example.org"])
    expect(mail.to).to eq(["operator@example.org", "chief@example.org"])
  end

  it "renders the body" do
    expect(mail.text_part.body.to_s).to match("Server: xyzmirth")
    expect(mail.text_part.body.to_s).to match("Channel: MyChannel")
    expect(mail.text_part.body.to_s).to match("Connector: DestoConnecto")
    expect(mail.text_part.body.to_s).to match("Type: ok")
    expect(mail.text_part.body.to_s).to match("Lorem ipsum dolor sit amet")
    expect(sanitize(mail.html_part.body.decoded, tags: [])).to match("Server: xyzmirth")
    expect(sanitize(mail.html_part.body.decoded, tags: [])).to match("Channel: MyChannel")
    expect(sanitize(mail.html_part.body.decoded, tags: [])).to match("Connector: DestoConnecto")
    expect(sanitize(mail.html_part.body.decoded, tags: [])).to match("Type: ok")
    expect(sanitize(mail.html_part.body.decoded, tags: [])).to match("Lorem ipsum dolor sit amet")
  end

  describe "without mail_to" do
    it "doesn't render anything" do
      expect(Mirco).to receive(:mail_to).and_return([])
      expect(mail.to).to eq([])
    end
  end

end
