class CommentsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  #skip_before_filter :verify_authenticity_token
  require 'net/http'
  require 'uri'
  require 'json'
  def create
    comment=Comment.new(post_id: params[:post_id],content: params[:content],name: params[:name])
    comment.save
    if comment.valid?
      render json: {status:200,data:comment}
    else
      render json: {status:400,message:"error"}
    end
  end
  def index
    comment=Comment.where(post_id: params[:post_id]).order(updated_at: :desc)
    #comment=Comment.where(post_id: params[:post_id]).order(updated_at: :asc)
    #comment=Comment.where(post_id: params[:post_id]).order(name: :desc)
    #comment=Comment.where(post_id: params[:post_id]).order(name: :asc)
    render json: {status:200,data:comment}
  end
  def count 
    comment=Comment.where(post_id: params[:post_id])
    cnt=comment.length
    render json:  {status:200,data:cnt}
  end
  def destroy
    comment=Comment.find_by(id: params[:id])
    comment.destroy
    render json: {status:200}
  end
end
