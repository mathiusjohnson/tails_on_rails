class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token
  helper_method :current_user

  def index
  end
  
  def current_user
    print 'before token'
    # if we want to change the sign-in strategy, this is the place to do it
    return unless session[:token]

    print 'has token!' + session[:token]
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    token = crypt.decrypt_and_verify session[:token]
    user_id = token.gsub('user-id:', '').to_i
    User.find user_id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
end
