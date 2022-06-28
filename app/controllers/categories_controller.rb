class CategoriesController < ApplicationController
    before_action :set_category, only: [:projects, :show, :update, :destroy]
    before_action :authorize_request, except: [:index, :projects, :show]

    def index
        @categories = Category.all
        json_response(@categories)
    end

    def projects
        json_response(@category.projects)
    end

    # POST /categories
    def create
        # @project = current_user.categories.create!(project_params)
        @category = Category.create!(category_params)
        # @category = Category.find(params[:category_id])
        # @project.categories << @category
        json_response(@category, :created)
    end

    # GET /categories/:id
    def show
        json_response(@category)
    end

    # PUT /categories/:id
    def update
        @category.update(category_params)
        head :no_content
    end

    # DELETE /categories/:id
    def destroy
        @category.destroy
        head :no_content
    end

    private

    def category_params
        # whitelist params
        params.permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
    end
end
