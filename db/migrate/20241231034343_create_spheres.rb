class CreateSpheres < ActiveRecord::Migration[7.2]
  def change
    create_table :spheres do |t|
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.string :slug
      t.datetime :expires_at

      t.timestamps
    end
  end
end
