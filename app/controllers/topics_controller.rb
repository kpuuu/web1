class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.all
    @topics_pages = Topic.all
    respond_with(@topics)
  end

  def show
    redirect_to posts_path(:forum_id => params[:forum_id], :topic_id => params[:id])
  end

  def new
    @topic = Topic.new
    @post = Post.new
    respond_with(@topic)
  end

  def edit
  end

  def create
    @topic = Topic.new(:name => params[:topic][:name], :forum_id => params[:forum_id])
    @topic.save!
    @post = Post.new(:body => params[:post][:body], :topic_id => @topic.id)
    @post.save!
    respond_with(@topic)
  end

  def update
    @topic.update(topic_params)
    respond_with(@topic)
  end

  def destroy
    #@topic = Topic.find(params[:id])
    #@topic.posts.each { |post| post.destroy }
    @topic.destroy
    respond_with(@topic)
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name, cat_attributes:[:id])
    end
end
