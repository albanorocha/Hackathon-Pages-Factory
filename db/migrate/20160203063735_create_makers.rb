class CreateMakers < ActiveRecord::Migration
  def change
    create_table :makers do |t|

      t.timestamps null: false
    end
  end
end
