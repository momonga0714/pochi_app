require 'rails_helper'

describe SoopsController, type: :controller do

  let(:params) do
    { params: {  soop: attributes_for(:soop) } }
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
        user = create(:user)
        sign_in user
        soops = create_list(:soop,3,user_id: user.id)
        get :menu_index
        expect(assigns(:soops)).to match(soops.sort{ |a, b| b.created_at <=> a.created_at })
      end

      it "menu_index.html.hamlに遷移すること" do
        soop = create(:soop)
        get :menu_index, params: { id: soop }
        expect(response).to render_template :menu_index
      end
    end

    describe 'GET #search' do
      it "@soopに正しい値が入っていること" do
        user = create(:user)
        sign_in user
        soops = create_list(:soop,3,user_id: user.id)
        get :search
        expect(assigns(:soops)).to match(soops.sort{ |a, b| b.created_at <=> a.created_at } )
      end
      it "search.html.hamlに遷移すること" do
        soop = create(:soop)
        get :search, params: { id: soop }
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
        soop = create(:soop)
        get :edit, params: { id: soop }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #show' do
      it "menu_index.html.hamlに遷移すること" do
        soop = create(:soop)
        get :show, params: { id: soop }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #menu_index' do
      it "トップページに遷移すること" do
        soop = create(:soop)
        soop_params = { user_id: nil}
        get :menu_index, params: { id: soop, soop: soop_params}
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
      it 'データベースにデータの保存が行われなかったか' do
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

  describe 'PATCH #update' do
    context 'ログインしていて、かつ更新に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの更新ができたか' do
        soop = create(:soop)
        soop_params = { soop_name: 'new_name!'}
        patch :update, params: { id: soop, soop: soop_params }
        expect(soop.reload.soop_name).to eq 'new_name!'
      end
      it '更新後、期待通りのページにリダイレクトしているか' do
        soop = create(:soop)
        soop_params = { soop_name: 'new_name!'}
        patch :update, params: { id: soop, soop: soop_params }
        expect(response).to redirect_to menu_index_soops_path
      end
    end

    context 'ログインしているが、保存に失敗した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの保存が行われなかったか' do
        soop = create(:soop)
        soop_params = { soop_name: nil}
        patch :update, params: { id: soop, soop: soop_params }
        expect(soop.reload.soop_name).to_not eq nil
      end
      it '意図したビューにリダイレクトしているか' do
        soop = create(:soop)
        soop_params = { soop_name: nil}
        patch :update, params: { id: soop, soop: soop_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        soop = create(:soop)
        soop_params = { user_id: nil}
        patch :update, params: { id: soop, soop: soop_params }
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
        soop = create(:soop)
        expect{delete :destroy, params: { id: soop }}.to change(Soop, :count).by(-1)
      end
      it '削除後、期待通りのページにリダイレクトしているか' do
        soop = create(:soop)
        delete :destroy, params: { id: soop }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        soop = create(:soop)
        soop_params = { user_id: nil}
        delete :destroy, params: { id: soop, soop: soop_params }
        expect(response).to redirect_to root_path
      end
    end
  end
end

