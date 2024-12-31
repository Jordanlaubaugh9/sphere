# app/services/create_sphere_service.rb
class CreateSphereService
  def initialize(user_name, sphere_name)
    @user_name = user_name
    @sphere_name = sphere_name
  end

  def call
    ActiveRecord::Base.transaction do
      # Create the user
      user = User.create(name: @user_name)
      return nil unless user.persisted?

      # Create the sphere
      sphere = Sphere.new(
        name: @sphere_name,
        created_by_id: user.id
      )
      sphere.slug = "/#{sphere.name.parameterize}"
      
      return nil unless sphere.save
      
      # Create the sphere membership for the creator
      sphere.sphere_memberships.create!(user: user)
      
      # Return both user and sphere for the controller to handle session
      return { user: user, sphere: sphere }
    end
  end
end
