require 'rails_helper'

describe MainsController, type: :controller do

  let(:params) do
    { params: {  main: attributes_for(:main) } }
  end

  context 'login' do
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
        user = create(:user)
        sign_in user
        mains = create_list(:main,3,user_id: user.id)
        get :menu_index
        expect(assigns(:mains)).to match(mains.sort{ |a, b| b.created_at <=> a.created_at })
      end

      it "menu_index.html.hamlに遷移すること" do
        main = create(:main)
        get :menu_index, params: { id: main }
        expect(response).to render_template :menu_index
      end
    end

    describe 'GET #search' do
      it "@mainに正しい値が入っていること" do
        user = create(:user)
        sign_in user
        mains = create_list(:main,3,user_id: user.id)
        get :search
        expect(assigns(:mains)).to match(mains.sort{ |a, b| b.created_at <=> a.created_at } )
      end
      it "search.html.hamlに遷移すること" do
        main = create(:main)
        get :search, params: { id: main }
        expect(response).to render_template :search
      end
    end
  end

  context 'ログアウトしている状態' do
    describe 'GET #new' do
      it "menu_index.html.hamlに遷移すること" do
        get :new
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #edit' do
      it "menu_index.html.hamlに遷移すること" do
        main = create(:main)
        get :edit, params: { id: main }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #show' do
      it "menu_index.html.hamlに遷移すること" do
        main = create(:main)
        get :show, params: { id: main }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #menu_index' do
      it "トップページに遷移すること" do
        main = create(:main)
        main_params = { user_id: nil}
        get :menu_index, params: { id: main, main: main_params}
        redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしていて、かつ保存に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの保存ができたか' do
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
      it 'データベースにデータの保存が行われなかったか' do
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

  describe 'PATCH #update' do
    context 'ログインしていて、かつ更新に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの更新ができたか' do
        main = create(:main)
        main_params = { main_name: 'new_name!'}
        patch :update, params: { id: main, main: main_params }
        expect(main.reload.main_name).to eq 'new_name!'
      end
      it '更新後、期待通りのページにリダイレクトしているか' do
        main = create(:main)
        main_params = { main_name: 'new_name!'}
        patch :update, params: { id: main, main: main_params }
        expect(response).to redirect_to menu_index_mains_path
      end
    end

    context 'ログインしているが、保存に失敗した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの保存が行われなかったか' do
        main = create(:main)
        main_params = { main_name: nil}
        patch :update, params: { id: main, main: main_params }
        expect(main.reload.main_name).to_not eq nil
      end
      it '意図したビューにリダイレクトしているか' do
        main = create(:main)
        main_params = { main_name: nil}
        patch :update, params: { id: main, main: main_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        main = create(:main)
        main_params = { user_id: nil}
        patch :update, params: { id: main, main: main_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていて、かつ削除に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの削除ができたか' do
        main = create(:main)
        expect{delete :destroy, params: { id: main }}.to change(Main, :count).by(-1)
      end
      it '削除後、期待通りのページにリダイレクトしているか' do
        main = create(:main)
        delete :destroy, params: { id: main }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        main = create(:main)
        main_params = { user_id: nil}
        delete :destroy, params: { id: main, main: main_params }
        expect(response).to redirect_to root_path
      end
    end
  end
end

