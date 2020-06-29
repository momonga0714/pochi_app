require 'rails_helper'


describe MainsController, type: :controller do
  before do
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

  describe 'GET #show' do
    it "@mainに正しい値が入っていること" do
      main = create(:main)
      get :show, params: { id: main }
      expect(assigns(:main)).to eq main
    end

    it "show.html.hamlに遷移すること" do
      main = create(:main)
      get :show, params: { id: main }
      expect(response).to render_template :show
    end
  end

  describe 'GET #menu_index' do
    it "@mainに正しい値が入っていること" do
      mains = create_list(:main,3)
      get :menu_index
      expect(assigns(:mains)).to match(mains.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "menu_index.html.hamlに遷移すること" do
      main = create(:main)
      get :menu_index, params: { id: main }
      expect(response).to render_template :menu_index
    end
  end

  describe 'GET #search' do
    it "@mainに正しい値が入っていること" do
      mains = create_list(:main,3)
      get :search
      expect(assigns(:mains)).to match(mains.sort{ |a, b| b.created_at <=> a.created_at } )
    end
    it "search.html.hamlに遷移すること" do
      main = create(:main)
      get :search, params: { id: main }
      expect(response).to render_template :search
    end
  end


  # describe MainsController, type: :controller do

  #   render_views
  # let(:user) { create(:user) }
  # # let(:group) { create(:group)}
  # # let(:groups) { user.groups }
  # let(:main) { create(:main)}
  # let(:mains) { create_list(:main,3) }
  # # let(:group_id) do
  # #   {params: { group_id: group.id }}
  # # end
  # # let(:params) do
  # #   { params: { group_id: group.id, main: attributes_for(:main) } }
  # # end
  
  

  describe 'GET #menu_index' do
    
    context 'login' do

      before do
        user = create(:user)
        sign_in user
        get :menu_index
      end

      # it 'リクエストされたmainを@mainに割り当てます' do
      #   expect(assigns(:main)).to be_a_new(Main)
      # end

      # it 'assigns the requested mains to @mains' do
      #   mains = create_list(:main,3)
      #   expect(assigns(:mains)).to eq mains
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
    { params: {  main: attributes_for(:main) } }
  end

  describe 'POST #create' do
    
    context 'ログインしていて、かつ保存に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにメッセージの保存ができたか' do
        expect{post :create, params}.to change(Main, :count).by(1)
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
        main = create(:main)
        expect{post :create, params: { main: attributes_for(:main, main_name: nil,genre_id: nil,type_id: nil,user_id: nil,resipi_images: nil) }
        }.to change(Main, :count).by(0)
      end
      it '意図したビューにリダイレクトしているか' do
        post :create, params
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
      post :create,params: { main: attributes_for(:main, user_id: nil) }
      expect(response).to redirect_to root_path
      end
    end
    end
  end

