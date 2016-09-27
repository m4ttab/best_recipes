class RecipesController < ApplicationController
before_action :find_recipe, only: [:show, :edit, :update, :destroy] 
before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:category].blank?
			@recipe = Recipe.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@recipe = Recipe.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def my
		@recipe = current_user.recipes.order("created_at DESC")
		render :index
	end

	def show
		if @recipe.reviews.blank?
			@average_review = 0
		else
			@average_review = @recipe.reviews.average(:rating).round(2)
		end
	end

	def new
		@recipe = current_user.recipes.build
		@categories = Category.all.map{ |c| [c.name, c.id]}
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)
		@recipe.category_id = params[:category_id]
			if @recipe.save
				redirect_to @recipe, notice: "Successfully created new recipe"
			else
				render 'new'
			end
	end

	def edit
		@categories = Category.all.map{ |c| [c.name, c.id]}
	end

	def update
		@recipe.category_id = params[:category_id]
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, :category_id, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end






end
