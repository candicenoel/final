class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @place = Place.find_by_id(params[:place_id])
    return render_not_found if @place.blank?

    @place.comments.create(comment_params.merge(user: current_user))
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
