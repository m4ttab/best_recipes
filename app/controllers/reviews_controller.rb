class ReviewsController < ApplicationController
	before_action :find_recipe
	before_action :find_review, only: [:edit, :update, :destroy]

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.recipe_id = @recipe.id
		@review.user_id = current_user.id

		if @review.save
			redirect_to recipe_path(@recipe)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @review.update(review_params)
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to recipe_path(@recipe)
	end

	private

	def review_params
		params.require(:review).permit(:rating, :comment)
	end

	def find_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end
end
