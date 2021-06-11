class PostsController < ApplicationController
  protect_from_forgery
  require 'json'
  def index
    #@posts = Post.all.order(updated_at: :desc)
    #@posts = Post.all.order(updated_at: :asc)
    #@posts = Post.all.order(title: :desc)
    #@posts = Post.all.order(title: :asc)
    @posts = Post.all
  end
  def get
    @post=Post.all
    json_hash=@post
    render json: json_hash
  end
  def create
    #@post=Post.new(title: params[:title],content: params[:content],name: params[:name])
    #@post.save
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @post=Post.new(title: json_hash["title"],content: json_hash["content"],name: json_hash["name"])
    @post.save
    json_hash=@post
    render json: json_hash
    #redirect_to("/posts/index")
  end
  def edit
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @post=Post.find_by(id: json_hash["id"])
    @post.title= json_hash["title"]
    @post.content= json_hash["content"]
    @post.name= json_hash["name"]
    @post.save
    json_hash=@post
    render json: json_hash
    #@post = Post.find_by(id: params[:id])
  end
  def count
    @post=Post.all
    cnt=@post.length
    render json: {status:200,count:cnt}
  end
  def destroy
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @post=Post.find_by(id: json_hash["id"])
    @post.destroy
    render json: {status:200}
    #redirect_to("/posts/index")
  end
  def show
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @post=Post.find_by(id: json_hash["id"])
    json_hash=@post
    render json: json_hash
  end

end
