# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      # Redirect or render as needed
      redirect_to spheres_new_path, notice: 'User created successfully.'
    else
      render :new # Render a form to create a user if it fails
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
