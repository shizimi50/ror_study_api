module Api
    module V1
        class PostsController < ApplicationController
            before_action :set_post, only: [:show, :update, :destroy]
            before_action :comment_count, only: [:index]


            # GET | api/v1/posts
            def index
                sortkey = params[:sortkey] #ソートパラメータ
                q = params[:q] #検索パラメータ
                results = Post.where('title LIKE ? OR content LIKE ? OR post_created_by LIKE ?', "%#{q}%", "%#{q}%", "%#{q}%");
                if q.blank? #検キーが入力されていない場合
                    render json: { status: 200, message: "success", data: { posts: results.order(sortkey) }}  
                else 
                    render json: { status: 200, message: "success", data: { posts: results.order(sortkey) }}  
                end
            end

            # GET | api/v1/posts/:id
            def show
                render json: { status: 200, message: "success", data: { post: @post } }
            end

            # POST | api/v1/posts
            def create
                post = Post.new(post_params)
                post[:post_created_by] = '名無し'
                if post.save
                    render json: { status: 200, message: "success", data: { post: post } }
                else
                    render json: { status: 400, message: post.errors.full_messages }
                end
            end

            # PUT | api/v1/posts/:id
            def update
                if @post.update(post_params)
                    render json: { status: 200, message: "success", data: { post: @post } }
                else                
                    render json: { status: 400, message: @post.errors.full_messages }
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

