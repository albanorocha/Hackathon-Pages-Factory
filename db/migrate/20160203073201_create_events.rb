class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :code
      t.string :name
      t.date :date
      t.string :address
      t.text :description
      t.boolean :release_sign_up
      t.boolean :published

      t.timestamps null: false
    end
  end
end
