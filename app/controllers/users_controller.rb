class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers, :messages]
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした'
      render :edit
    end
  end
  
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def messages
   @user = User.find(params[:id])
   @messages = Message.where(receive_id: current_user.id).order(created_at: :desc).page(params[:page])
   @send_id = []
   @result = []
   @messages.each do |message|
     @send_id << message
     @result = @send_id.uniq{|m| m[:user_id]}.page(params[:page])
   end
   counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :battle_app, :kiryoku, :profile, :password, :password_confirmation, :icon)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
