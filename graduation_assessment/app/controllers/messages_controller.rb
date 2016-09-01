class MessagesController < ApplicationController

	def index
		@messages = Message.all
	end

	def new
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)

		if @message.save
			flash[:notice] = "Thanks for adding a message!"
			redirect_to messages_path
		else
			flash[:notice] = "Something went wrong when adding your new message..."
			render :new
		end
	end

	private
	def message_params
		params.require(:message).permit(:name, :body)
	end
end
