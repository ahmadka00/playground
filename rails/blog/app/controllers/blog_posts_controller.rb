class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    def index
        #@blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
        @blog_posts = policy_scope(BlogPost).sorted
        @pagy, @blog_posts = pagy(@blog_posts)
    end

    def show 
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def new
        @blog_post = BlogPost.new
        authorize @blog_post
    end

    def create
        @blog_post = current_user.blog_posts.build(blog_post_params)
        authorize @blog_post
        #
        # @blog_post = BlogPost.new(blog_post_params)
        # @blog_post.user = current_user
        #
        # @blog_post = BlogPost.new(blog_post_params.merge({user: current_user}))
        if @blog_post.save
            redirect_to @blog_post
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
    end

    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @blog_post.destroy
        redirect_to root_path
    end


    # private class
    private

    def blog_post_params       
        params.require(:blog_post).permit(:title, :content, :cover_image, :published_at)
    end  

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
        authorize @blog_post
        #or use this line same result as above condition
        # @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : @blog_post = BlogPost.published.find(params[:id])
    end 

end