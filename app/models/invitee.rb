class Invitee < ApplicationRecord
  has_many :invitations
  has_many :events, through: :invitations
  
  validates :phone_number, presence: true
  validates :name, presence: true
end
