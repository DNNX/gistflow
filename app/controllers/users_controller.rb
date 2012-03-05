class UsersController < ApplicationController
  def create
    account = Account::Github.find_or_create_by_omniauth(omniauth)
    self.current_user = account.user
    if current_user.newbie?
      redirect_to user_tags_path(current_user)
    else
      redirect_to root_path
    end
  end
  
  def show
    @user = User.find_by_username(params[:id])
    @posts = @user.posts.page(params[:page])
    self.sidebar_presenter = SidebarPresenter.new(@user)
  end
  
protected

  def omniauth
    request.env['omniauth.auth']
  end
end