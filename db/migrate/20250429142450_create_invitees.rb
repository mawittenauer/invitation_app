class CreateInvitees < ActiveRecord::Migration[7.1]
  def change
    create_table :invitees do |t|
      t.string :name
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
