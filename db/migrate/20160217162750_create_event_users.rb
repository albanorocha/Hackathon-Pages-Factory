class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.integer :role
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true

      t.timestamps null: false
    end
  end
end
