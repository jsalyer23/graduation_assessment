require 'rails_helper'

RSpec.describe ApiController, type: :controller do
	let!(:message1) { Message.create(name: "Bob Nelson", body: "I love signing guest books!") }
  let!(:message2) { Message.create(name: "Tim Gibbins", body: "Your site is just the best.") }

  describe "Api Request" do

  	it "All messages are displayed as JSON" do
  		visit "api/messages"

  		expect(page.body).to eq({:messages => Message.all}.to_json)
  	end
  end
end
