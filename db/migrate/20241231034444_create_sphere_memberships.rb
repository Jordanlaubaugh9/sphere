class CreateSphereMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :sphere_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sphere, null: false, foreign_key: true
      t.string :role
      t.datetime :last_active_at

      t.timestamps
    end
  end
end
