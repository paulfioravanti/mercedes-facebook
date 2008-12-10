class InvitationsController < ApplicationController

  # POST /invitations
  def create
    @sent_to_ids = params[:ids]
  end
  
  # GET /invitations/new
  def new
    if should_update_profile?
      update_profile
    end
    @from_user_id = facebook_session.user.to_s
  end

  private

  # TODO put method description in here
  def should_update_profile?
    # :from gets passed from the following pages:
    # invitations/new.erb
    params[:from]
  end
  
  # TODO put method description in here
  def update_profile
    @user = facebook_session.user
    @user.profile_fbml =
      render_to_string(:partial => "profile",
                       :layout => "fmbl_tags",
                       :locals => {:from => params[:from]})
  end

end
