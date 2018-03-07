class UserController < ApplicationController

  def new_login
    binding.pry
  end

  def login
    new_token = request_access_token
    return json_response(ERROR, :unprocessable_entity) if new_token.nil?
    user = User.find_by_username params[:username]
    if user.nil?
      new_user = User.new
      new_user.username = params[:username]
      new_user.save!
    end
    json_response({status: "ok", token: new_token})
  end

  def index
    response = verify_access_token
    return json_response(ERROR, :unauthorized) if response.nil?
    users = User.select(:id, :display_name).take(params[:limit])
    json_response(
      status: "ok",
      page: params[:page],
      limit: params[:limit],
      total: users.size,
      data: users
    )
  end

  def create
    display_name = params[:displayName]
    response = verify_access_token
    return json_response(ERROR, :unauthorized) if response.nil?
    if response["user_id"]
      user = User.find_by_username response["user_id"]
      user.display_name = display_name
      user.save!
      json_response({status: "ok", userId: user.id, displayName: user.display_name})
    end
  end

end
