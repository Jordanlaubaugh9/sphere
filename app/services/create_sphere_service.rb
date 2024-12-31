# app/services/create_sphere_service.rb
class CreateSphereService
  def initialize(user_name, sphere_name)
    @user_name = user_name
    @sphere_name = sphere_name
  end

  def call
    user = User.create(name: @user_name)
    return nil unless user.persisted?

    sphere = Sphere.new(
      name: @sphere_name,
      created_by_id: user.id
    )
    sphere.slug = "/#{sphere.name.parameterize}"

    sphere.save ? sphere : nil
  end
end
