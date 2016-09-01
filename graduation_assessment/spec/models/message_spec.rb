require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message1) { Message.create(name: "Bob Nelson", body: "I love signing guest books!") }
  let!(:message2) { Message.create(name: "Tim Gibbins", body: "Your site is just the best.") }

  def sign_guest_book(message={})
  	visit "/"
  	fill_in "Name", with: message[:name]
  	fill_in "message[body]", with: message[:body]
  	click_button "Create Message"
  end

  describe "Signing the Guest Book" do

  	it "A welcome message is displayed" do
  		visit "/"

  		expect(page).to have_content("Welcome! Please sign the guest book")
  	end

  	it "New entries are added to the guest book" do
  		sign_guest_book(name: "Casey Jones", body: "Cool guest book man...")

  		expect(page).to have_content("Casey Jones")
  		expect(page).to have_content("Cool guest book man...")
  		expect(page).to have_content(message1.name)
  	end

  	it "A success message is shown after signing guest book" do 
  		sign_guest_book(name: "Mandy Scale", body: "I hope I get to sign this again.")

  		expect(page).to have_content("Thanks for adding a message!")
  		expect(page).to_not have_content("Something went wrong when adding your new message...")
  	end

  	it "User's name and message are displayed" do
  		sign_guest_book(name: "George Boone", body: "Yesterday is here")

  		expect(page).to have_content("George Boone")
  		expect(page).to have_content("Yesterday is here")
  	end

  	it "All entries are displayed" do
  		sign_guest_book(name: "Fish Johnson", body: "Great things can happen")
  		message3 = Message.find(Message.maximum('id'))

  		expect(page).to have_content(message1.name)
  		expect(page).to have_content(message2.name)
  		expect(page).to have_content(message3.name)
  		expect(page).to have_content(message1.body)
  	end
  end
end
