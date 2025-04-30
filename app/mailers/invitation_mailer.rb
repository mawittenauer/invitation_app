class InvitationMailer < ApplicationMailer
  default from: 'invitations@example.com'
  
  def invitation_email(invitation, rsvp_url)
    @invitation = invitation
    @event = invitation.event
    @invitee = invitation.invitee
    @rsvp_url = rsvp_url
    
    mail(
      to: @invitee.email,
      subject: "You're invited to #{@event.title}!"
    )
  end
end
