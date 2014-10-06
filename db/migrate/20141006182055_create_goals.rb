class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user
      t.text :content
      t.string :title, null: false

      t.timestamps
    end
  end
end
