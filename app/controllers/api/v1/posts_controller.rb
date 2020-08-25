class Api::V1::PostsController < ApplicationController
  
  def login_date
    user = User.find_by(email: params[:session][:email].downcase)
    serializer = UserSerializer.new(user)
    render json: serializer.serialized_json
  end
end
