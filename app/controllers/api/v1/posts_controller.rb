class Api::V1::PostsController < ApplicationController
  
  def login_date
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      serializer = UserSerializer.new(user)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
end
