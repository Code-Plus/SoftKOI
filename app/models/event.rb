class Event < ActiveRecord::Base

  include PublicActivity::Model
  tracked only: [:day_of_event]

  before_create :set_date
  before_update :set_updated_at

  validates :description, presence: true
  validates :start_time, presence: true

  private

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end
end
