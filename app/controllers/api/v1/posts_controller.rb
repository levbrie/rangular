module Api
	module V1
		class PostsController < ApplicationController
			respond_to :json

			def index
				respond_with Post.all
			end

			def create
				respond_with Post.create(params[:post])
			end
		end
	end
end
