class ChatroomsController < ApplicationController

    def show
        @message = Message.new
        #Restriction to prevent overflow
        @messages = Message.all
    end

end
