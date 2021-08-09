class GraphqlController < ApplicationController
  def execute
    result = GraphqlTutorialSchema.execute(
      query, 
      variables: variables, 
      context: context, 
      operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def query
    params[:query]
  end

  def variables
    ensure_hash params[:variables]
  end

  def operation_name
    params[:operationName]
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

  def context
    {
      session: session,
      current_user: AuthToken.user_from_token(session[:token])
    }
  end
  

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { error: { message: error.message, backtrace: error.backtrace }, data: {} }, status: 500
  end
end
