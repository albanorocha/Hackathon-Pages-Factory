class CreateAdminProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description

      t.text :problem
      t.string :problem_image
      t.text :solution
      t.string :solution_image
      t.text :team_description
      t.string :team_image

      t.string :facebook_link
      t.string :instagram_link
      t.string :youtube_link

      t.string :email

      t.belongs_to :team, index: true

      t.timestamps null: false
    end
  end
end
