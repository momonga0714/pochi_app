require 'rails_helper'


describe SubsController, type: :controller do
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

  describe 'GET #show' do
    it "@subに正しい値が入っていること" do
      sub = create(:sub)
      get :show, params: { id: sub }
      expect(assigns(:sub)).to eq sub
    end

    it "show.html.hamlに遷移すること" do
      sub = create(:sub)
      get :show, params: { id: sub }
      expect(response).to render_template :show
    end
  end

  describe 'GET #menu_index' do
    it "@subに正しい値が入っていること" do
      subs = create_list(:sub,3)
      get :menu_index
      expect(assigns(:subs)).to match(subs.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "menu_index.html.hamlに遷移すること" do
      sub = create(:sub)
      get :menu_index, params: { id: sub }
      expect(response).to render_template :menu_index
    end
  end

  describe 'GET #search' do
    it "@subに正しい値が入っていること" do
      subs = create_list(:sub,3)
      get :search
      expect(assigns(:subs)).to match(subs.sort{ |a, b| b.created_at <=> a.created_at } )
    end
    it "search.html.hamlに遷移すること" do
      sub = create(:sub)
      get :search, params: { id: sub }
      expect(response).to render_template :search
    end
  end


  # describe subsController, type: :controller do

  #   render_views
  # let(:user) { create(:user) }
  # # let(:group) { create(:group)}
  # # let(:groups) { user.groups }
  # let(:sub) { create(:sub)}
  # let(:subs) { create_list(:sub,3) }
  # # let(:group_id) do
  # #   {params: { group_id: group.id }}
  # # end
  # # let(:params) do
  # #   { params: { group_id: group.id, sub: attributes_for(:sub) } }
  # # end
  
  

  describe 'GET #menu_index' do
    
    context 'login' do

      before do
        user = create(:user)
        sign_in user
        get :menu_index
      end

      # it 'リクエストされたsubを@subに割り当てます' do
      #   expect(assigns(:sub)).to be_a_new(sub)
      # end

      # it 'assigns the requested subs to @subs' do
      #   subs = create_list(:sub,3)
      #   expect(assigns(:subs)).to eq subs
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
    { params: {  sub: attributes_for(:sub) } }
  end

  describe 'POST #create' do
    
    context 'ログインしていて、かつ保存に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにメッセージの保存ができたか' do
        expect{post :create, params}.to change(Sub, :count).by(1)
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
        sub = create(:sub)
        expect{post :create, params: { sub: attributes_for(:sub, sub_name: nil,genre_id: nil,type_id: nil,user_id: nil,resipi_images: nil) }
        }.to change(Sub, :count).by(0)
      end
      it '意図したビューにリダイレクトしているか' do
        post :create, params
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
      post :create,params: { sub: attributes_for(:sub, user_id: nil) }
      expect(response).to redirect_to root_path
      end
    end
    end
  end

