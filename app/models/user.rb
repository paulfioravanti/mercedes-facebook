class User < ActiveRecord::Base

  belongs_to :house

  # Method to find or create an application user 
  # instance given a Facebook ID
  def self.for(facebook_id, facebook_session = nil)
    # :include house info for minor speed tuning
    returning find_or_create_by_facebook_id(facebook_id,
                                            :include => [:house]) do |user|
      # Check to see if the session_key needs to
      # be updated
      unless facebook_session.nil?
        user.store_session(facebook_session.session_key)
      end
    end
  end

  private

  # Session keys will change after 1 hour of not
  # using. This method will update session_key in
  # database only when the facebook session_key has
  # changed.
  def store_session(session_key)
    if self.session_key != session_key
      update_attribute(:session_key, session_key)
    end
  end

  # Recreate Facebooker::Session object outside of
  # a request
  def facebook_session
    @facebook_session ||=
      returning Facebooker::Session.create do |session|
        # Facebook sessions are only good for 1 hour after storing
        # secure_with! associates a session key to a
        # Facebooker::Session object
        session.secure_with!(session_key, facebook_id, 1.hour.from_now)
      end
  end
end
