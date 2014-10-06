class AddPrivacyToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :is_private, :boolean, default: false, null: false
  end
end
