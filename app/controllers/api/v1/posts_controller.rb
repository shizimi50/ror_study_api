module Api
    module V1
        class PostsController < ApplicationController
            before_action :set_post, only: [:show, :specific_comments, :update, :destroy]
            before_action :comment_count, only: [:index]


            # GET | api/v1/posts
            def index
                sortkey = params[:sortkey] #ソートパラメータ
                q = params[:q] #検索パラメータ
                if q == params[:q]
                    results = Post.where('title LIKE ? OR content LIKE ? OR post_created_by LIKE ?', "%#{q}%", "%#{q}%", "%#{q}%");
                    if sortkey == "sort1"
                        render json: { status: 200, message: "success", data: { posts: results.order(updated_at: "DESC") } }                           
                    elsif sortkey == "sort2"
                        render json: { status: 200, message: "success", data: { posts: results.order(updated_at: "ASC") } }                
                    elsif sortkey == "sort3"
                        render json: { status: 200, message: "success", data: { posts: results.order(title: "DESC") } }                
                    elsif sortkey == "sort4"
                        render json: { status: 200, message: "success", data: { posts: results.order(title: "ASC") } }                
                    elsif sortkey == "sort5"
                        render json: { status: 200, message: "success", data: { posts: results.order(comment_count: "DESC") } }                
                    elsif sortkey == "sort6"
                        render json: { status: 200, message: "success", data: { posts: results.order(comment_count: "ASC") } } 
                    else
                        render json: { status: 200, message: "success", data: { posts: results } }                      
                    end
                elsif q == ''
                    render json: { status: 200, message: "success", data: { posts: '' } }
                else #検索されていない場合
                    if sortkey == "sort1"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(updated_at: "DESC") } }                           
                    elsif sortkey == "sort2"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(updated_at: "ASC") } }                
                    elsif sortkey == "sort3"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(title: "DESC") } }                
                    elsif sortkey == "sort4"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(title: "ASC") } }                
                    elsif sortkey == "sort5"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(comment_count: "DESC") } }                
                    elsif sortkey == "sort6"
                        render json: { status: 200, message: "success", data: { posts: @posts.order(comment_count: "ASC") } } 
                    else
                        render json: { status: 200, message: "success", data: { posts: @posts } }                      
                    end                     
                end
            end

            # GET | api/v1/posts/:id
            def show
                render json: { status: 200, message: "success", data: { post: @post, comment_count: comment_count }}
            end

            # GET | api/v1/posts/:id/specific_comments(掲示板詳細+それに紐づくコメントの詳細）
            def specific_comments
                sortkey = params[:sortkey] #ソートパラメータ
                @comments = @post.comments
                if sortkey == "sort1"
                    render json: { status: 200, message: "Loaded some comments", data: @comments.order(created_at: "DESC")}                           
                elsif sortkey == "sort2"
                    render json: { status: 200, message: "Loaded some comments", data: @comments.order(created_at: "ASC")}                
                elsif sortkey == "sort3"
                    render json: { status: 200, message: "Loaded some comments", data: @comments.order(comment_created_by: "DESC")}                
                elsif sortkey == "sort4"
                    render json: { status: 200, message: "Loaded some comments", data: @comments.order(comment_created_by: "ASC")}                
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
                    response_bad_request_title                      
                elsif post.content.blank?
                    response_bad_request_content
                else
                    render status: 400, json: { status: 400, message: "文字数を確認ください" }
                end
            end

            # PUT | api/v1/posts/:id
            def update
                if @post.title.blank?
                    response_bad_request_title                      
                elsif @post.content.blank?
                    response_bad_request_content
                else                
                    @post.update(post_params)
                    render json: { status: 200, message: "success", data: { post: @post } }
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

            # コメントカウント
            def comment_count
                @posts = Post.all
                post_count = @posts.map{ |post| 
                    [post.id, post.comments.count] #コメント数を表示させるならto_sで文字列化
                }.to_h
                # => {1=>"2", 2=>"2", 3=>"0", 4=>"1"}
                    # 上記のコメントデータのidと記事のidが一致した場合に、コメント数をcount属性に格納
                    post_count.map { |key, value|
                        @posts.map { |post|
                            if post.id === key
                                post["comment_count"] = value
                                post.save                               
                            end
                        }.compact    
                    }
            end


            def post_params
                params.permit(:title, :content, :post_created_by)
            end
            
                    
        end
    end    
end

