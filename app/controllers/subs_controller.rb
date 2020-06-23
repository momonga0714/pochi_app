class SubsController < ApplicationController
  before_action :set_sub,only:[:show,:destroy,:edit,:update]

  def index
    @subs = Sub.includes(:resipi_images)
  end

  def new
    @sub = Sub.new
    @sub.resipi_images.new
  end

  def create
    @sub = Sub.new(subs_params)
    @sub.user_id = current_user.id
    if @sub.type_id.blank? == true || @sub.genre_id.blank? == true
      redirect_to "/"
      flash[:alert] = '料理の種類かカテゴリーを選択し再度登録してください。'
    else
      if @sub.save
        redirect_to "/"
        flash[:notice] = '登録が完了しました'
      else
        @sub.resipi_images.new
        redirect_to "/"
        flash[:alert] = '料理がすでに登録されているか、空欄のため登録ができませんでした。'
      end
    end
    
  end
  def show
    @sub_images = @sub.resipi_images
  end

  def edit
    
  end

  def update
    if @sub.update(sub_update_params)
      flash[:notice] = '商品の編集が完了しました'
      redirect_to "/subs/menu_index"
    else
      flash[:alert] = '商品の編集に失敗しました'
      redirect_to "/"
    end
  end

  def destroy
    @sub.destroy
    redirect_to root_path
    flash[:notice] = '料理が削除されました'
  end

  def menu_index
    # @subs = Sub.includes(:resipi_images).order("created_at DESC").page(params[:page]).per(5)
    @subs = Sub.includes(:resipi_images).order("created_at DESC")
  end

  def search
    # @subs = Sub.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(5)
    @subs = Sub.search(params[:keyword]).order("created_at DESC")
  end


  private
  def subs_params
    params.require(:sub).permit(:id,:sub_name,:genre_id,:type_id,:comment,:user_id,resipi_images_attributes: [:image])
  end

  def sub_update_params
    params.require(:sub).permit(:id,:sub_name,:genre_id,:type_id,:comment,:user_id,[resipi_images_attributes: [:image, :_destroy, :id]])
  end

  def set_sub
    @sub = Sub.find(params[:id])
  end
end
