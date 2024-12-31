class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    
    if @user.save
      # Add the user to the sphere they're trying to join
      sphere = Sphere.find(params[:sphere_id])
      sphere.sphere_memberships.create(user: @user)
      
      # Set some form of session authentication
      session[:user_id] = @user.id
      
      redirect_to sphere_path(sphere), notice: 'Welcome to the sphere!'
    else
      redirect_to sphere_path(params[:sphere_id]), alert: 'Could not create user.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
