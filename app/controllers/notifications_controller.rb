class NotificationsController < ApplicationController

  def index
    @notifications = PublicActivity::Activity.where(read_at: nil)
  end

  def read
    @notifications = PublicActivity::Activity.where(read_at: nil)
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end
end
