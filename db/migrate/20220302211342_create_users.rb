class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :company_name
      t.string :phone_number
      t.string :role

      t.timestamps
    end
  end
end
