class CommentsController < ApplicationController
  protect_from_forgery
  require 'json'
  def new
    json_str  = request.body.read     
    json_hash = JSON.parse(json_str)  
    @comment=Comment.new(f_id: json_hash["f_id"],content: json_hash["content"],name: json_hash["name"])
    @comment.save
    json_hash=Comment.last(1)
    render json: json_hash
  end
end