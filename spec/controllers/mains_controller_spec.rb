require 'rails_helper'

describe MainsController, type: :controller do

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do
    it "@mainに正しい値が入っていること" do
      main = create(:main)
      get :edit, params: { id: main }
      expect(assigns(:main)).to eq main
    end

    it "edit.html.hamlに遷移すること" do
      main = create(:main)
      get :edit, params: { id: main }
      expect(response).to render_template :edit
    end
  end

end


