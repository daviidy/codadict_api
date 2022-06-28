class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :update, :destroy]
    before_action :authorize_request, except: [:index, :show]

    # GET /projects
    # def all
    #     @projects = Project.all
    #     json_response(@projects)
    # end

    def index
        @projects = Project.all
        json_response(@projects)
    end

    def myProjects
        json_response(current_user.projects)
    end

    # POST /projects
    def create
        # @project = current_user.projects.create!(project_params)
        @project = current_user.projects.create!(project_params)
        params[:category_ids].each do |i|
            @category = Category.find(i)
            @project.categories << @category
        end
        json_response(@project, :created)
    end

    # GET /projects/:id
    def show
        json_response(@project)
    end

    # PUT /projects/:id
    def update
        @project.update(project_params)
        head :no_content
    end

    # DELETE /projects/:id
    def destroy
        @project.destroy
        head :no_content
    end

    private

    def project_params
        # whitelist params
        params.require(:project).permit(:title, :description, :budget, category_ids: [] )
    end

    def set_project
        @project = Project.find(params[:id])
    end
end
