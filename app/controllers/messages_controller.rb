require 'bunny'

class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @message = Message.new
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  def publish
    logger.debug "Publishing message #{params[:message]}"

    bunny = Bunny.new
    bunny.start
    exchange = bunny.exchange "rabbithole"
    exchange.publish "#{params[:message].to_json}", :key => "message"
    bunny.stop

    respond_to do |format|
      format.html { redirect_to messages_path, notice: 'Message was successfully published.' }
    end
  end


  # POST /messages
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
      else
        format.html { redirect_to messages_path, error: 'There was an error processing the message'  }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
    end
  end
end
