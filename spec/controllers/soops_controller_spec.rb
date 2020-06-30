require 'rails_helper'


describe SoopsController, type: :controller do
  before:each do
    user = create(:user)
    sign_in user
  end
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

  describe 'GET #show' do
    it "@soopに正しい値が入っていること" do
      soop = create(:soop)
      get :show, params: { id: soop }
      expect(assigns(:soop)).to eq soop
    end

    it "show.html.hamlに遷移すること" do
      soop = create(:soop)
      get :show, params: { id: soop }
      expect(response).to render_template :show
    end
  end

  describe 'GET #menu_index' do
    it "@soopに正しい値が入っていること" do
      soops = create_list(:soop,3)
      get :menu_index
      expect(assigns(:soops)).to match(soops.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "menu_index.html.hamlに遷移すること" do
      soop = create(:soop)
      get :menu_index, params: { id: soop }
      expect(response).to render_template :menu_index
    end
  end

  describe 'GET #search' do
    it "@soopに正しい値が入っていること" do
      soops = create_list(:soop,3)
      get :search
      expect(assigns(:soops)).to match(soops.sort{ |a, b| b.created_at <=> a.created_at } )
    end
    it "search.html.hamlに遷移すること" do
      soop = create(:soop)
      get :search, params: { id: soop }
      expect(response).to render_template :search
    end
  end


  # describe soopsController, type: :controller do

  #   render_views
  # let(:user) { create(:user) }
  # # let(:group) { create(:group)}
  # # let(:groups) { user.groups }
  # let(:soop) { create(:soop)}
  # let(:soops) { create_list(:soop,3) }
  # # let(:group_id) do
  # #   {params: { group_id: group.id }}
  # # end
  # # let(:params) do
  # #   { params: { group_id: group.id, soop: attributes_for(:soop) } }
  # # end
  
  

  describe 'GET #menu_index' do
    
    context 'login' do

      before do
        user = create(:user)
        sign_in user
        get :menu_index
      end

      # it 'リクエストされたsoopを@soopに割り当てます' do
      #   expect(assigns(:soop)).to be_a_new(soop)
      # end

      # it 'assigns the requested soops to @soops' do
      #   soops = create_list(:soop,3)
      #   expect(assigns(:soops)).to eq soops
      # end

      it 'renders the :menu_index template' do
        expect(response).to render_template :menu_index
      end
    end

    context 'not login' do
      it 'redirects to new_user_session_path' do
        redirect_to new_user_session_path
      end
    end
  end

  let(:params) do
    { params: {  soop: attributes_for(:soop) } }
  end

  describe 'POST #create' do
    
    context 'ログインしていて、かつ保存に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにメッセージの保存ができたか' do
        expect{post :create, params}.to change(Soop, :count).by(1)
      end
      it '/ページにリダイレクトしているか' do
        post :create, params
        expect(response).to redirect_to root_path
      end
    end


    context 'ログインしているが、保存に失敗した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにメッセージの保存が行われなかったか' do
        soop = create(:soop)
        expect{post :create, params: { soop: attributes_for(:soop, soop_name: nil,genre_id: nil,type_id: nil,user_id: nil,resipi_images: nil) }
        }.to change(Soop, :count).by(0)
      end
      it '意図したビューにリダイレクトしているか' do
        post :create, params
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
      post :create,params: { soop: attributes_for(:soop, user_id: nil) }
      expect(response).to redirect_to root_path
      end
    end
    end
  end

