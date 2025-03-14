class CreateEventOrganizers < ActiveRecord::Migration[7.2]
  def change
    create_table :event_organizers do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :description
      t.string :contact_number

      t.timestamps
    end
    add_index :event_organizers, :email
  end
end
