class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :invitee, null: false, foreign_key: true
      t.string :status
      t.string :token

      t.timestamps
    end
  end
end
