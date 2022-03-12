module Api::V1
  class ApiController < ActionController::API
    # Handle the token authentication for every user, globally
    acts_as_token_authentication_handler_for User
    before_action :require_authentication!


    # Error thrown if user not present
    private
    def require_authentication!
      throw(:warden, scope: :user) unless current_user.presence
    end

  end
end
