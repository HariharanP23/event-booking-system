class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :address
      t.string :contact_number

      t.timestamps
    end
    add_index :customers, :email
  end
end
