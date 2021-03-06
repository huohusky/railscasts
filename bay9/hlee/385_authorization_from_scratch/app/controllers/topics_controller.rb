class TopicsController < ApplicationController
  before_filter :authorize, only: :edit

  def index
    @topics = Topic.order("sticky desc")
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to @topic, notice: "Created topic."
    else
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      redirect_to topics_url, notice: "Updated topic."
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url, notice: "Destroyed topic."
  end

private
  def authorize
    if !current_permission.allow?
      redirect_to root_url, alert: "Not authorized"
    end
  end

  def topic_params
    params.require(:topic).permit(:name, :sticky)
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end
end
