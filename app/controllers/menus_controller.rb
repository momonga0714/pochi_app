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
    @menus = Menu.includes(:resipi_images)
  end

  

  private
  def menu_params
    params.require(:menu).permit(:id)
  end

  def set_main
    if current_user != nil
      @mains = Main.where(user_id: current_user.id)
    else
      @mains = Main.all
    end
  end

  def set_sub
    if current_user != nil
      @subs = Sub.where(user_id: current_user.id)
    else
      @subs = Sub.all
    end
  end

  def set_soop
    if current_user != nil
      @soops = Soop.where(user_id: current_user.id)
    else
      @soops = Soop.all
    end
  end

end
