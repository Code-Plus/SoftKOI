class Event < ActiveRecord::Base

  include PublicActivity::Model
  tracked only: [:day_of_event]
  #
  # before_filter :set_timezone
  before_create :set_date
  before_update :set_updated_at

  private


  def set_timezone
    Time.zone = current_user.time_zone
  end

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end
end
