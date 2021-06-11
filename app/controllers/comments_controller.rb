class CommentsController < ApplicationController
  protect_from_forgery
  require 'json'
  def new
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @comment=Comment.new(f_id: json_hash["f_id"],content: json_hash["content"],name: json_hash["name"])
    @comment.save
    json_hash=@comment
    render json: json_hash
  end
  def get
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    #@comment=Comment.all
    @comment=Comment.where(f_id: json_hash["f_id"])
    json_hash=@comment
    render json: json_hash
  end
  def count
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @comment=Comment.where(f_id: json_hash["f_id"])
    cnt=@comment.length
    render json: {status:200,count:cnt}
  end
end
