class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :new]
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            flash[:success] = "Post created."
            redirect_to posts_path
        else
            flash.now[:error] = "Something went horribly wrong."
            render :new, status: :unprocessable_entity
        end
    end

    def index
        @posts = Post.all
    end

    private

    def post_params
        params.require(:post).permit(:text)
    end
end
