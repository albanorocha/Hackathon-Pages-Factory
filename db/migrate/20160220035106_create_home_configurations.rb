class CreateHomeConfigurations < ActiveRecord::Migration
  def change
    create_table :home_configurations do |t|

      t.timestamps null: false
    end
  end
end
