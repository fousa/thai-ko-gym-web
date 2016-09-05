class AuthenticateUser
  prepend SimpleCommand

  def initialize(request)
    @email, @password = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
  end

  def call
    JsonWebToken.encode user_id: user.id if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_for_authentication(email: email)
    return user if user.try(:valid_password?, password)

    errors.add :user, 'Invalid credentials'
    nil
  end
end
