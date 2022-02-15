class ProposalsController < ApplicationController
    before_action :set_project
    before_action :set_project_proposal, only: [:show, :update, :destroy]

    # GET /projects/:project_id/proposals
    def index
        json_response(@project.proposals)
    end

    # GET /projects/:project_id/proposals/:id
    def show
        json_response(@proposal)
    end

    # POST /projects/:project_id/proposals
    def create
        @proposal = @project.proposals.create!(proposal_params)
        json_response(@proposal)
    end

    # PUT /projects/:project_id/proposals/:id
    def update
        @proposal.update(proposal_params)
        head :no_content
    end

    # DELETE /projects/:project_id/proposals/:id
    def destroy
        @proposal.destroy
        head :no_content
    end

    private

    def proposal_params
        params.permit(:price, :deadline)
    end

    def set_project
        @project = Project.find(params[:project_id])
    end

    def set_project_proposal
        @proposal = @project.proposals.find_by!(id: params[:id]) if @project
    end
end
