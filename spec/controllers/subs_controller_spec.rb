require 'rails_helper'

describe SubsController, type: :controller do

  let(:params) do
    { params: {  sub: attributes_for(:sub) } }
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
        user = create(:user)
        sign_in user
        subs = create_list(:sub,3,user_id: user.id)
        get :menu_index
        expect(assigns(:subs)).to match(subs.sort{ |a, b| b.created_at <=> a.created_at })
      end

      it "menu_index.html.hamlに遷移すること" do
        sub = create(:sub)
        get :menu_index, params: { id: sub }
        expect(response).to render_template :menu_index
      end
    end

    describe 'GET #search' do
      it "@subに正しい値が入っていること" do
        user = create(:user)
        sign_in user
        subs = create_list(:sub,3,user_id: user.id)
        get :search
        expect(assigns(:subs)).to match(subs.sort{ |a, b| b.created_at <=> a.created_at } )
      end
      it "search.html.hamlに遷移すること" do
        sub = create(:sub)
        get :search, params: { id: sub }
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
        sub = create(:sub)
        get :edit, params: { id: sub }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #show' do
      it "menu_index.html.hamlに遷移すること" do
        sub = create(:sub)
        get :show, params: { id: sub }
        redirect_to menu_index_menus_path
      end
    end

    describe 'GET #menu_index' do
      it "トップページに遷移すること" do
        sub = create(:sub)
        sub_params = { user_id: nil}
        get :menu_index, params: { id: sub, sub: sub_params}
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
      it 'データベースにデータの保存が行われなかったか' do
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

  describe 'PATCH #update' do
    context 'ログインしていて、かつ更新に成功した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの更新ができたか' do
        sub = create(:sub)
        sub_params = { sub_name: 'new_name!'}
        patch :update, params: { id: sub, sub: sub_params }
        expect(sub.reload.sub_name).to eq 'new_name!'
      end
      it '更新後、期待通りのページにリダイレクトしているか' do
        sub = create(:sub)
        sub_params = { sub_name: 'new_name!'}
        patch :update, params: { id: sub, sub: sub_params }
        expect(response).to redirect_to menu_index_subs_path
      end
    end

    context 'ログインしているが、保存に失敗した場合' do
      before do
        user = create(:user)
        sign_in user
      end
      it 'データベースにデータの保存が行われなかったか' do
        sub = create(:sub)
        sub_params = { sub_name: nil}
        patch :update, params: { id: sub, sub: sub_params }
        expect(sub.reload.sub_name).to_not eq nil
      end
      it '意図したビューにリダイレクトしているか' do
        sub = create(:sub)
        sub_params = { sub_name: nil}
        patch :update, params: { id: sub, sub: sub_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        sub = create(:sub)
        sub_params = { user_id: nil}
        patch :update, params: { id: sub, sub: sub_params }
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
        sub = create(:sub)
        expect{delete :destroy, params: { id: sub }}.to change(Sub, :count).by(-1)
      end
      it '削除後、期待通りのページにリダイレクトしているか' do
        sub = create(:sub)
        delete :destroy, params: { id: sub }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていない場合' do
      it '意図したビューにリダイレクトしているか'do
        sub = create(:sub)
        sub_params = { user_id: nil}
        delete :destroy, params: { id: sub, sub: sub_params }
        expect(response).to redirect_to root_path
      end
    end
  end
end

