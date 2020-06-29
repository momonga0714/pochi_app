require 'rails_helper'


describe SubsController, type: :controller do

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do
    it "@subに正しい値が入っていること" do
      sub = create(:sub)
      get :edit, params: { id: sub }
      expect(assigns(:sub)).to eq sub
    end

    it "edit.html.hamlに遷移すること" do
      sub = create(:sub)
      get :edit, params: { id: sub }
      expect(response).to render_template :edit
    end
  end


end


