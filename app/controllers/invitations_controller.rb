# app/controllers/invitations_controller.rb
class InvitationsController < ApplicationController
  before_action :authenticate_user!, except: [:rsvp]
  
  def create
    @event = current_user.events.find(params[:event_id])
    @invitee = Invitee.find_or_create_by(invitee_params)
    
    if @invitee.persisted?
      @invitation = Invitation.create(event: @event, invitee: @invitee, status: 'pending')
      send_invitation(@invitation)
      redirect_to @event, notice: 'Invitation was sent successfully.'
    else
      redirect_to @event, alert: 'Failed to create invitation.'
    end
  end
  
  def rsvp
    @invitation = Invitation.find_by(token: params[:token])
    
    if @invitation
      @invitation.update(status: params[:status])
      @event = @invitation.event
      @invitee = @invitation.invitee
      render :rsvp
    else
      render plain: "Invalid invitation link", status: :not_found
    end
  end
  
  private
  
  def invitee_params
    params.require(:invitee).permit(:name, :phone_number, :email)
  end
  
  def send_invitation(invitation)
    rsvp_url = rsvp_invitation_url(invitation.token)
    InvitationMailer.invitation_email(invitation, rsvp_url).deliver_now
  rescue StandardError => e
    Rails.logger.error("Failed to send invitation email: #{e.message}")
  end
end
