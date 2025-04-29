class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee
  
  before_create :generate_token
  
  enum status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }
  
  private
  
  def generate_token
    self.token = SecureRandom.urlsafe_base64(16)
  end
end
