class CreateAdminTeamUsers < ActiveRecord::Migration
  def change
    create_table :team_users do |t|
      t.integer :role
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true

      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
