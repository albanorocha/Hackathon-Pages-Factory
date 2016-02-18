class CreateAdminProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :image
      t.text :why
      t.text :how
      t.text :what
      t.text :description

      t.belongs_to :team, index: true

      t.timestamps null: false
    end
  end
end
