class PostsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  require 'json'
  def index
    #post = Post.all.order(updated_at: :desc) 
    #post = Post.all.order(updated_at: :asc)
    #post = Post.all.order(title: :desc)
    #post = Post.all.order(title: :asc)
    post = Post.all.each do|p|
      p.count=p.count_post_id
    end
    post=post.sort_by{|p| -p.count} #降順
    #post=post.sort_by{|p| p.count}　#昇順
    render json: {status:200,data:post}
  end
  def create
    post=Post.new(title: params[:title],content: params[:content],name: params[:name])
    post.save
    if post.valid?
      render json: {status:200,data:post}
    else
      render json: {status:400,message:"error"}
    end
  end
  def update
    post=Post.find_by(id:params[:id])
    post.title= params[:title]
    post.content= params[:content]
    post.name=params[:name]
    post.save
    render json: {status:200,data:post}
  end
  def count
    post=Post.all
    cnt=post.length
    render json: {status:200,data:cnt}
  end
  def destroy
    post=Post.find_by(id:params[:id])
    post.destroy
    render json: {status:200}
  end
  def show 
    post=Post.find_by(id:params[:id])
    render json: {status:200,data:post}
  end
  def search
    post = Post.search(params[:keyword])
    render json: {status:200,data:post}
  end

end
