module Api
    module V1
        class CommentsController < ApplicationController
            before_action :set_comment, only: [:show, :update, :destroy]

            # GET | api/v1/posts/:post_id/comments
            def index
                comments = Comment.where(post_id: params[:post_id]) #投稿idはパラメータから取得
                render json: { status: 200, message: "success", data: { comments: comments.order(params[:sortkey]) }}  
            end
            
            # GET | api/v1/posts/:post_id/comments/:id
            def show
                render json: { status: 200, message: "success", data: { comment: @comment } }
            end
            
            # POST | api/v1/posts
            def create
                comment = Comment.new(comment_params)
                comment[:comment_created_by] = '名無し'
                if comment.save
                    render json: { status: 200, message: "success", data: { comment: comment } }
                else
                    render json: { status: 400, message: comment.errors.full_messages }
                end
            end

            # PUT | api/v1/posts/:id
            def update
                if @comment.update(comment_params)
                    render json: { status: 200, message: "success", data: { comment: @comment } }
                else
                    render json: { status: 400, message: comment.errors.full_messages }
                end
            end

            # DELETE | api/v1/posts/:id
            def destroy
                @comment.destroy
                render json: { status: 200, message: "success", data: { comment: @comment } }
            end
            

            private

            def set_comment
                @comment = Comment.find_by(id: params[:id])
            end
       

            def comment_params
                params.permit(:comment, :comment_created_by, :post_id)
            end
        end
    end    
end
