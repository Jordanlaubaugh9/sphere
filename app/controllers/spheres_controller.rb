# app/controllers/spheres_controller.rb
class SpheresController < ApplicationController
  before_action :set_sphere, except: [:create]
  before_action :authenticate_user!, only: [:show]

  def new
    @sphere = Sphere.new
  end

  def create
    service = CreateSphereService.new(params[:sphere][:created_by], params[:sphere][:name])
    result = service.call

    respond_to do |format|
      if result
        # Set the user session
        session[:user_id] = result[:user].id
        
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('message', 'Sphere created successfully!'),
            turbo_stream.after('message', 
              "<script>window.location.href = '#{sphere_path(result[:sphere])}';</script>")
          ]
        end
        format.html { redirect_to sphere_path(result[:sphere]), notice: 'Sphere was successfully created.' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('message', 'Failed to create sphere.')
        }
        format.html { redirect_to root_path, alert: 'Failed to create sphere.' }
      end
    end
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
  end

  private

  def set_sphere
    @sphere = Sphere.find_by(slug: "/#{params[:id]}") || Sphere.find(params[:id])
  end

  def authenticate_user!
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user&.spheres&.include?(@sphere)
    
    # If user isn't authenticated, the view will show the registration form
    render :show
  end

  def sphere_params
    params.require(:sphere).permit(:name, :created_by)
  end
end
