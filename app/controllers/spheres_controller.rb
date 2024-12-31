# app/controllers/spheres_controller.rb
class SpheresController < ApplicationController
  def new
    @sphere = Sphere.new
  end

  def create
    service = CreateSphereService.new(params[:sphere][:created_by], params[:sphere][:name])
    @sphere = service.call

    if @sphere
      redirect_to sphere_path(@sphere), notice: 'Sphere was successfully created.'
    else
      render :new, alert: 'Failed to create sphere.'
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
