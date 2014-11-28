class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @topic = Topic.find(params[:topic_id], :include => forum)
    respond_to do |format|
        format.html # index.rhtml
        format.xml { render :xml => @posts.to_xml }
    end 
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params[:post]
    end
end
