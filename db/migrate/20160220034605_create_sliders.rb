class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :title
      t.string :link
      t.text :description

      t.references :sliderable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
