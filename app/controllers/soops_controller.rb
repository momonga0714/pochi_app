class SoopsController < ApplicationController

  before_action :set_soop,only:[:show,:destroy,:edit,:update]


  def index
    @soops = Soop.includes(:resipi_images)
  end

  def new
    @soop = Soop.new
    @soop.resipi_images.new
  end

  def create
    @soop = Soop.new(soops_params)
    @soop.user_id = current_user.id
    if @soop.type_id.blank? == true || @soop.genre_id.blank? == true
      redirect_to "/"
      flash[:alert] = '料理の種類かカテゴリーを選択し再度登録してください。'
    else
      if @soop.save
        redirect_to "/"
        flash[:notice] = '登録が完了しました'
      else
        @soop.resipi_images.new
        redirect_to "/"
        flash[:alert] = '料理がすでに登録されているため、登録ができませんでした。'
      end
    end
  end

  def show
    @soop_images = @soop.resipi_images
  end

  def destroy
    @soop.destroy
    redirect_to root_path
    flash[:notice] = '料理が削除されました'
  end

  def edit
    
  end

  def update
    if @soop.update(soop_update_params)
      flash[:notice] = '商品の編集が完了しました'
      redirect_to "/"
    else
      flash[:alert] = '商品の編集に失敗しました'
      redirect_to "/"
    end
  end

  def menu_index
    @soops = Soop.includes(:resipi_images).order("created_at DESC").page(params[:page]).per(5)
  end

  def search
    @soops = Soop.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(5)
    
  end




  private
  def soops_params
    params.require(:soop).permit(:id,:soop_name,:genre_id,:type_id,:comment,:user_id,resipi_images_attributes: [:image])
  end

  def soop_update_params
    params.require(:soop).permit(:id,:sub_name,:genre_id,:type_id,:comment,:user_id,[resipi_images_attributes: [:image, :_destroy, :id]])
  end

  def set_soop
    @soop = Soop.find(params[:id])
  end
end
