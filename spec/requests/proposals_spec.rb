require 'rails_helper'

RSpec.describe 'Proposals API' do
  # Initialize the test data
  let!(:project) { create(:project) }
  let!(:proposals) { create_list(:proposal, 20, project_id: project.id) }
  let(:project_id) { project.id }
  let(:id) { proposals.first.id }

  # Test suite for GET /projects/:project_id/proposals
  describe 'GET /projects/:project_id/proposals' do
    before { get "/projects/#{project_id}/proposals" }

    context 'when project exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all proposals' do
        expect(json.size).to eq(20)
      end
    end

    context 'when project does not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project with 'id'=0/)
      end
    end
  end

  # Test suite for GET /projects/:project_id/proposals/:id
  describe 'GET /projects/:project_id/proposals/:id' do
    before { get "/projects/#{project_id}/proposals/#{id}" }

    context 'when proposal exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the proposal' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when proposal does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Proposal/)
      end
    end
  end

  # Test suite for POST /projects/:project_id/proposals
  describe 'POST /projects/:project_id/proposals' do
    let(:valid_attributes) { { price: 2000, deadline: Date.today } }

    context 'when request attributes are valid' do
      before { post "/projects/#{project_id}/proposals", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when an invalid request' do
      before { post "/projects/#{project_id}/proposals", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Price can't be blank, Deadline can't be blank/)
      end
    end
  end

  # Test suite for PUT /projects/:project_id/proposals/:id
  describe 'PUT /projects/:project_id/proposals/:id' do
    let(:valid_attributes) { { price: 2500 } }

    before { put "/projects/#{project_id}/proposals/#{id}", params: valid_attributes }

    context 'when proposal exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the proposal' do
        updated_proposal = Proposal.find(id)
        expect(updated_proposal.price).to match(2500.0)
      end
    end

    context 'when the proposal does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Proposal/)
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}/proposals/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
