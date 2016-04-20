require 'rails_helper'

RSpec.describe ApiKeysController, :controller do
  let(:valid_attributes) {
    { notes: 'test', perms: 'read' }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all api_keys as @api_keys" do
      api_key = ApiKey.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:api_keys)).to eq([api_key])
    end
  end

  describe "GET #new" do
    it "assigns a new api_key as @api_key" do
      get :new, {}, valid_session
      expect(assigns(:api_key)).to be_a_new(ApiKey)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ApiKey" do
        expect {
          post :create, { api_key: valid_attributes }, valid_session
        }.to change(ApiKey, :count).by(1)
      end

      it "assigns a newly created api_key as @api_key" do
        post :create, { api_key: valid_attributes }, valid_session
        expect(assigns(:api_key)).to be_a(ApiKey)
        expect(assigns(:api_key)).to be_persisted
      end

      it "redirects to the created api_key" do
        post :create, { api_key: valid_attributes }, valid_session
        expect(response).to redirect_to(api_keys_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested api_key" do
      api_key = ApiKey.create! valid_attributes
      expect {
        delete :destroy, { id: api_key.to_param }, valid_session
      }.to change(ApiKey, :count).by(-1)
    end

    it "redirects to the api_keys list" do
      api_key = ApiKey.create! valid_attributes
      delete :destroy, { id: api_key.to_param }, valid_session
      expect(response).to redirect_to(api_keys_url)
    end
  end

end
