class CommentController < ApplicationController

  def index
    comments = Comment.take(params[:limit])
    json_response(
      status: "ok",
      page: params[:page],
      limit: params[:limit],
      total: comments.size,
      data: comments
    )
  end

  def show
    comment = Comment.find_by_id params[:id]
    json_response(
      status: "ok",
      data: comment
    )
  end

  def update
    response = verify_access_token
    return json_response({error: "error", description: "deskripsi error"}, :unauthorized) if response.nil?
    comment = Comment.find_by_id params[:id]
    comment.comment = params[:comment]
    comment.save!
    json_response(
        status: "ok",
        data: comment
    )
  end

  def destroy
    response = verify_access_token
    return json_response({error: "error", description: "deskripsi error"}, :unauthorized) if response.nil?
    comment = Comment.find_by_id params[:id]
    comment.destroy!
    json_response(
        status: "ok",
    )
  end

  def create
    content = params[:comment]
    response = verify_access_token
    return json_response({error: "error", description: "deskripsi error"}, :unauthorized) if response.nil?
    if response["user_id"]
      user = User.find_by_username response["user_id"]
      comment = Comment.new
      comment.user_id = user.id
      comment.comment = content
      comment.created_by = user.display_name
      comment.save!
      json_response({status: "ok", data: comment})
    end
  end
end
