class Invitee < ApplicationRecord
  has_many :invitations
  has_many :events, through: :invitations
  
  validates :email, presence: true
  validates :name, presence: true
end
