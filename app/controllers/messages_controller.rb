class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @message = Message.new
    @messages = Message.find_all_by_from_user_id current_user.id

    @users = {}
    User.all.collect { |user| @users[user.email] = user.id }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.where(:from_user_id => current_user.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  def new
    @message = Message.new

    @users = {}
    User.all.collect { |user| @users[user.email] = user.id }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def edit
    @users = {}
    User.all.collect { |user| @users[user.email] = user.id }
    @message = Message.where(:from_user_id => current_user.id).find(params[:id])
  end

  def publish
    logger.debug "Publishing message #{params[:message]}"

    Message.publish params[:message]

    respond_to do |format|
      format.html { redirect_to messages_path, notice: 'Message was successfully published.' }
    end
  end

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
    @message = Message.where(:from_user_id => current_user.id).find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_path }
    end
  end
end
