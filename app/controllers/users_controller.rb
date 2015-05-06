class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#处理成功
      log_in @user
  		flash[:success] = "欢迎加入爱吐槽！"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #更新成功的情况
      flash[:success] = "资料更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end
   
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除"
    redirect_to users_url
  end 

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, 
  			:passwor_confirmation)
  	end
  
    #确保用户已经登陆
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请先登陆"
        redirect_to login_url
      end
    end

    #确保是当前用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
