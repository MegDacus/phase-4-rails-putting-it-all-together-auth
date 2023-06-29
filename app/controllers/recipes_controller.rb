class RecipesController < ApplicationController
    def index
        if session[:user_id]
            recipes = Recipe.where(user_id: session[:user_id])  
            render json: recipes, status: :ok
        else  
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])

        if user
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created
        else  
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    private 

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
