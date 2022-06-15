class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    before_action :authroize

    def index
        render json: Recipe.all, status: 201
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: 201
    end

    private

    def recipe_params
        params.permit(:user_id, :title, :instructions, :minutes_to_complete)
    end

    def authroize
        return render json: {errors: ["Please log in"]}, status: 401 unless session.include? :user_id
    end

    def record_invalid (invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
        
end
