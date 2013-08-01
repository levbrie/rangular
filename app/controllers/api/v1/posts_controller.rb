module Api
	module V1
		class PostsController < ApplicationController
			respond_to :json

			def index
				respond_with Post.all
			end

			def create
				respond_with Post.create(post_params)
			end

      def show
        respond_with Post.find(post_params)
      end

      def update 
        respond_with Post.update(params[:id], params[:post])
      end

      def destroy
        respond_with Post.destroy(params[:id])
      end

      private 
      def post_params
        params.require(:post).permit(:name, :content)
      end
		end
	end
end
