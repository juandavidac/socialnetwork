class ActivitiesController < ApplicationController
  def index
    @users= current_user.active_friends
    @users.push(current_user)
    case params[:current_user]
    when 'posts'
      @activities= PublicActivity::Activity.where(owner_id: @users, trackable_type: "Post").order('created_at DESC')
    else
      @activities= PublicActivity::Activity.where(owner_id: @users).order('created_at DESC')
    end
  end
end
