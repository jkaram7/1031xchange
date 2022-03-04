class MessagesController < ApplicationController

  def connection

    render({ :template => "messages/new.html.erb" })
  end

  def index

    @list_of_acquisition_criteria = AcquisitionCriterium.all
    @list_of_users = User.all
    @list_of_messages = Message.all
    
    #matching_messages = Message.where(sender_id: session.fetch(:user_id)).or(Message.where(recipient_id: session.fetch(:user_id))).order({ :created_at => :desc })
    matching_messages = nil

    if matching_messages != nil
      @list_of_threads = matching_messages.distinct.pluck(:acquisition_id, :sender_id, :recipient_id)
    else
      @list_of_threads = nil
    end

    render({ :template => "messages/index.html.erb" })
  end

  def conversations
    id_sender = params.fetch("sender_id")
    id_acquisition = params.fetch("criteria_id")

    matching_messages = Message.where(sender_id: id_sender).or(Message.where(recipient_id: id_sender)).where({:acquisition_id => id_acquisition})
    matching_messages = matching_messages.where(sender_id: session.fetch(:user_id)).or(Message.where(recipient_id: session.fetch(:user_id))).where({:acquisition_id => id_acquisition})

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    render({ :template => "messages/threads.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_messages = Message.where({ :id => the_id })

    @the_message = matching_messages.at(0)

    render({ :template => "messages/show.html.erb" })
  end

  def create

    the_message = Message.new
    the_message.sender_id = session.fetch(:user_id)
    the_message.recipient_id = params.fetch("rec_id")
    the_message.content = params.fetch("query_content")
    the_message.read = false
    the_message.acquisition_id = params.fetch("a_id")

    if the_message.valid?
      the_message.save
      redirect_to("/messages", { :notice => "Message sent successfully." })
    else
      redirect_to("/messages", { :notice => "Message failed to send." })
    end
  end

  def createThread

    the_message = Message.new
    the_message.sender_id = session.fetch(:user_id)
    the_message.recipient_id = params.fetch("rec_id")
    the_message.content = params.fetch("query_content")
    the_message.read = false
    the_message.acquisition_id = params.fetch("a_id")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.acquisition_id}/#{the_message.recipient_id}", { :notice => "Message sent successfully." })
    else
      redirect_to("/messages/#{the_message.acquisition_id}/#{the_message.recipient_id}", { :notice => "Message failed to send." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.sender_id = params.fetch("query_sender_id")
    the_message.recipient_id = params.fetch("query_recipient_id")
    the_message.content = params.fetch("query_content")
    the_message.read = params.fetch("query_read", false)
    the_message.acquisition_id = params.fetch("query_acquisition_id")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.id}", { :notice => "Message updated successfully."} )
    else
      redirect_to("/messages/#{the_message.id}", { :alert => "Message failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.destroy

    redirect_to("/messages", { :notice => "Message deleted successfully."} )
  end
end
