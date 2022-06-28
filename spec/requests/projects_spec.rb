require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  # initialize test data
  let(:user) { create(:user) }

  let!(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id }
  let!(:projects) { create_list(:project, 10, user_id: user.id) }
  let(:project) { projects.first }
  let(:category) { categories.first }
  let(:project_id) { projects.first.id }


  # authorize request
  let(:headers) { valid_headers }
  

  # Test suite for GET /projects
  describe 'GET /projects' do
    # make HTTP get request before each example
    before { get '/projects', params: {}, headers: headers }

    it 'returns projects' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /myèprojects
  describe 'GET /my-projects' do
    # make HTTP get request before each example
    before { get '/my-projects', params: {}, headers: headers }

    it 'returns user projects' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

   # Test suite for GET /categories/id/projects
  describe 'GET /categories/:id/projects' do
    before(:all) do
      @user = create(:user)
      @category = create(:category)
      @project = create(:project, user_id: @user.id)
      @project.categories << @category
    end
    # make HTTP get request before each example
    before { get "/categories/#{@category.id}/projects", params: {}, headers: headers }

    it 'returns projects per category' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /projects/:id
  describe 'GET /projects/:id' do
    before { get "/projects/#{project_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the project' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(project_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:project_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project with 'id'=100/)
      end
    end
  end

  # Test suite for POST /projects
  describe 'POST /projects' do
    # valid payload
    let(:valid_attributes) {{ 
      title: 'Project Euler', 
      description: 'any description', 
      budget: 2500,
      category_ids: [category_id]
    }.to_json}
    let(:invalid_attributes) {{ title: 'Project Euler' }.to_json}

    context 'when the request is valid' do
      before { post '/projects', params: valid_attributes, headers: headers }

      it 'creates a project' do
        expect(json['title']).to eq('Project Euler')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/projects', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank, Budget can't be blank/)
      end
    end
  end

  # Test suite for PUT /projects/:id
  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { title: 'Web app project' }.to_json }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
