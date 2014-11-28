class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @forums = Forum.all
    respond_with(@forums)
  end

  def show
    redirect_to topics_path(:forum_id => params[:id])
  end

  def new
    @forum = Forum.new
    respond_with(@forum)
  end

  def edit
  end

  def create
    @forum = Forum.new(forum_params)
    respond_to do |format|
      if @forum.save
        format.html { redirect_to forums_path }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @forum.update(forum_params)
    respond_with(@forum)
  end

  def destroy
    @forum.destroy
    respond_with(@forum)
  end

  private
    def set_forum
      @forum = Forum.find(params[:id])
    end

    def forum_params
       params.require(:forum).permit(:name, :description, cat_attributes: [:id])
    end
end
