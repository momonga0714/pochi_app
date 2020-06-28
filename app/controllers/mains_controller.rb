class MainsController < ApplicationController
  before_action :set_main, only:[:show,:destroy,:edit,:update]
  def index
    @mains = Main.includes(:resipi_images)
  end

  def new
    @main = Main.new
    @main.resipi_images.new
  end

  def show
    @main_images = @main.resipi_images
  end

  def create
    @main = Main.new(mains_params)
    if @main.user_id != nil
      @main.user_id = current_user.id
      if @main.type_id.blank? == true || @main.genre_id.blank? == true
        redirect_to "/"
        flash[:alert] = '料理の種類かカテゴリーを選択し再度登録してください。'
      else
        if @main.save
          redirect_to "/"
          flash[:notice] = '登録が完了しました'
        else
          @main.resipi_images.new
          redirect_to "/"
          flash[:alert] = '料理がすでに登録されているか、空欄のため登録ができませんでした。'
        end
      end
    else
      redirect_to "/"
      flash[:alert] = '料理の登録にはログインが必要です。'
    end
  end

  def edit
    
  end

  def update
    if @main.update(main_update_params)
      flash[:notice] = '商品の編集が完了しました'
      redirect_to "/mains/menu_index"
    else
      flash[:alert] = '商品の編集に失敗しました'
      redirect_to "/"
    end
  end

  def destroy
    @main.destroy
    redirect_to root_path
    flash[:notice] = '料理が削除されました'
  end

  def menu_index
    # @mains = Main.includes(:resipi_images).order("created_at DESC").page(params[:page]).per(5)
    @mains = Main.includes(:resipi_images).order("created_at DESC")
  end

  def search
    # @mains = Main.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(5)
    @mains = Main.search(params[:keyword]).order("created_at DESC")
    
  end

  def count
    @cnt = main.where(name: '検索結果').count
    render text: "検索結果は#(cnt)個です。"
  end


  private
  def mains_params
    params.require(:main).permit(:id,:main_name,:genre_id,:type_id,:comment,:user_id, resipi_images_attributes: [:image])
  end

  def main_update_params
    params.require(:main).permit(:id,:sub_name,:genre_id,:type_id,:comment,:user_id,[resipi_images_attributes: [:image, :_destroy, :id]])
  end

  def set_main
    @main = Main.find(params[:id])
  end
end
