require 'rails_helper'


describe SoopsController, type: :controller do

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do
    it "@soopに正しい値が入っていること" do
      soop = create(:soop)
      get :edit, params: { id: soop }
      expect(assigns(:soop)).to eq soop
    end

    it "edit.html.hamlに遷移すること" do
      soop = create(:soop)
      get :edit, params: { id: soop }
      expect(response).to render_template :edit
    end
  end


end


