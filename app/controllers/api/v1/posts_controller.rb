module Api
    module V1
        class PostsController < ApplicationController
            before_action :set_post, only: [:show, :specific_comments, :update, :destroy]


            # GET | api/v1/posts
            def index
                posts = Post.all
                render json: { status: 200, message: "success", data: { posts: posts } }
            end
            
            # GET | api/v1/posts/:id
            def show
                render json: { status: 200, message: "success", data: { post: @post } }
            end

            # GET | api/v1/posts/:id/specific_comments(掲示板詳細+それに紐づくコメントの詳細）
            def specific_comments
                @comments = @post.comments
                if @comments.nil?
                    render :show
                else
                    render json: { status: 'Success', message: 'Loaded some comments', data: @comments}
                end
            end
            
            # POST | api/v1/posts
            def create
                post = Post.new(post_params)
                if post.save
                    render json: { status: 200, message: "success", data: { post: post } }
                elsif post.title.blank?
                    response_bad_request                        
                else post.content.blank?
                    response_bad_request
                end
            end

            # PUT | api/v1/posts/:id
            def update
                if @post.update(post_params)
                    render json: { status: 200, message: "success", data: { post: @post } }
                else
                end
            end

            # DELETE | api/v1/posts/:id
            def destroy
                @post.destroy
                render json: { status: 200, message: "success", data: { post: @post } }
            end
            

            
            private

            def set_post
                @post = Post.find_by(id: params[:id])
            end

            def post_params
                params.permit(:title, :content, :post_created_by)
            end
            
                    
        end
    end    
end

