class Api::V1::PostsController < ApplicationController
  
  def login_date
    result = JSON.parse(params)
    user = User.find_by(email: result[:post][:email].downcase)
    if user && user.authenticate(result[:post][:password])
      serializer = UserSerializer.new(user)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
end
