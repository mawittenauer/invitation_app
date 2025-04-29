# app/controllers/invitations_controller.rb
class InvitationsController < ApplicationController
  before_action :authenticate_user!, except: [:rsvp]
  
  def create
    @event = current_user.events.find(params[:event_id])
    @invitee = Invitee.find_or_create_by(invitee_params)
    
    if @invitee.persisted?
      @invitation = Invitation.create(event: @event, invitee: @invitee, status: 'pending')
      send_invitation_sms(@invitation)
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
  
  def send_invitation_sms(invitation)
    client = Twilio::REST::Client.new
    rsvp_url = rsvp_invitation_url(invitation.token)
    
    message = client.messages.create(
      body: "You've been invited to #{invitation.event.title}! RSVP here: #{rsvp_url}",
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: invitation.invitee.phone_number
    )
  rescue Twilio::REST::RestError => e
    Rails.logger.error("Failed to send SMS: #{e.message}")
  end
end
