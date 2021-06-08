class PostsController < ApplicationController
  def index
    #@posts = Post.all.order(updated_at: :desc)
    #@posts = Post.all.order(updated_at: :asc)
    #@posts = Post.all.order(title: :desc)
    #@posts = Post.all.order(title: :asc)
    #@posts = Post.all
  end
  def new   
  end
  def create
    @post=Post.new(title: params[:title],content: params[:content],name: params[:name])
    @post.save
    redirect_to("/posts/index")
  end
end
