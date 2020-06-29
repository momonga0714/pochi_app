require 'rails_helper'


describe MenusController, type: :controller do

  
  describe 'GET #index' do
    it "@mainに正しい値が入っていること" do
      mains = create_list(:main,3)
      get :index
      expect(assigns(:mains)).to match(mains)
    end

    it "index.html.hamlに遷移すること"do
      main = create(:main) 
      get :index
      expect(response).to render_template :index
    end
  end

end


