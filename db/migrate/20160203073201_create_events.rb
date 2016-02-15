class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :descriptor
      t.string :name
      t.date :date
      t.string :address
      t.text :description
      t.string :image
      t.boolean :release_sign_up
      t.boolean :published
      t.belongs_to :admin, index: true

      t.timestamps null: false
    end
  end
end
