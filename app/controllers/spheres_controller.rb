# app/controllers/spheres_controller.rb
class SpheresController < ApplicationController
  def new
    @sphere = Sphere.new
  end

  def create
    service = CreateSphereService.new(params[:sphere][:created_by], params[:sphere][:name])
    @sphere = service.call

    # Add debugging to see what's happening
    Rails.logger.debug "Service response: #{@sphere.inspect}"
    Rails.logger.debug "Service errors: #{@sphere&.errors&.full_messages}"

    respond_to do |format|
      if @sphere&.persisted?  # Check if sphere was actually created and saved
        format.turbo_stream { 
          redirect_to sphere_path(@sphere), notice: 'Sphere was successfully created.' 
        }
        format.html { 
          redirect_to sphere_path(@sphere), notice: 'Sphere was successfully created.' 
        }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('message', 
            partial: 'shared/error_messages', 
            locals: { message: 'Failed to create sphere.' })
        }
        format.html { 
          redirect_to root_path, alert: 'Failed to create sphere.' 
        }
      end
    end
  end

  def show
    @sphere = Sphere.find(params[:id])
  end

  private

  def sphere_params
    params.require(:sphere).permit(:name, :created_by)
  end
end
