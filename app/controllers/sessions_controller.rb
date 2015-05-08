class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		#用户登入，重定向到用户资料页
  		if user.activated?
         log_in user
  		   params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		   redirect_back_or user
  	  else
  		#显示登陆错误消息
  		   message = "帐号未激活,请检查你邮箱激活链接"
         flash[:warning] = message
  	     redirect_to root_url
       end
     else
       flash.now[:danger] = "邮箱或密码错误"
       render 'new'
     end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
