class CreateViews < ActiveRecord::Migration[6.0]
  def change
    create_table :views do |t|
      t.integer :id_acquisition
      t.integer :id_viewer
      t.boolean :clicked
      t.boolean :potential_lead

      t.timestamps
    end
  end
end
