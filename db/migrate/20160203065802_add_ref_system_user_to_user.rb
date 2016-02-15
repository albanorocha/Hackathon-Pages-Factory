class AddRefSystemUserToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :system_user, polymorphic: true, index: true
    end
  end
end
