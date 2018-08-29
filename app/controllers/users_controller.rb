class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )
    # @user.first_name = params[:user][:first_name]
    # @user.last_name = params[:user][:last_name]
    # @user.email = params[:user][:email]
    # @user.password = params[:user][:password]
    # @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_url
    else
      render 'new'
      flash[:alert] = @user.errors.full_messages
    end
  end

  def user_session
    @user = User.find(session[:user_id])
  end

  def show
    @pledges = current_user.pledges
    @projects = current_user.projects
  end

  def bio
    @user = User.find(params[:id])
    @projects = Project.where(params[:project_id])
  end

end
