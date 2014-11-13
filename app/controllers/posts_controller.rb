class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "post successfully created"
      redirect_to root_url
    else
      render :new
    end
  end

# Confirms a signed-in user.
  def signed_in_user
    unless signed_in?
      #store_location
      flash[:danger] = "Please sign in."
      redirect_to signin_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
