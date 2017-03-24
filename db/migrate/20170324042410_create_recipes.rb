class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.integer :user_id

      t.string :name

      t.integer :prep_time
      t.integer :cook_time
      
      t.timestamps
    end
  end
end
