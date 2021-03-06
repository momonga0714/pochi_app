class MenusController < ApplicationController
  before_action :set_main, only:[:index,:menu_index,:main_menu_show,:sub_menu_show,:soop_menu_show]
  before_action :set_sub, only:[:index,:menu_index,:main_menu_show,:sub_menu_show,:soop_menu_show]
  before_action :set_soop, only:[:index,:menu_index,:main_menu_show,:sub_menu_show,:soop_menu_show]

  def index
    @menus = Menu.includes(:resipi_images)
  end

  def show
  end

  def menu_index
    if user_signed_in?
      @menus = Menu.includes(:resipi_images)
    else
      redirect_to "/"
      flash[:alert] = 'このページにアクセスするにはログインが必要です'
    end
  end

  private
  def menu_params
    params.require(:menu).permit(:id)
  end

  def set_main
    if user_signed_in?
      @mains = Main.where(user_id: current_user.id)
    else
      @mains = Main.all
    end
  end

  def set_sub
    if user_signed_in?
      @subs = Sub.where(user_id: current_user.id)
    else
      @subs = Sub.all
    end
  end

  def set_soop
    if user_signed_in?
      @soops = Soop.where(user_id: current_user.id)
    else
      @soops = Soop.all
    end
  end
end
