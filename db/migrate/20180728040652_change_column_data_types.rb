class ChangeColumnDataTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :prep_time, :string
    change_column :recipes, :cook_time, :string
  end
end
