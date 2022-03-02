class CreateAcquisitionCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :acquisition_criteria do |t|
      t.datetime :period_end_date
      t.string :product_type
      t.string :location
      t.float :trade_size
      t.integer :id_user
      t.text :notes
      t.boolean :active
      t.integer :priority
      t.float :cap_rate_min
      t.float :cap_rate_max
      t.string :property_sub_type
      t.float :occupancy
      t.string :return_profile
      t.string :preferred_tenant
      t.float :sq_feet

      t.timestamps
    end
  end
end
