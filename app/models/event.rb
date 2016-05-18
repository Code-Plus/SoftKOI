class Event < ActiveRecord::Base

  include PublicActivity::Model
  tracked only: [:day_of_event]

  before_create :set_date
  before_update :set_updated_at

  validates :description, presence: true
  validates_date :start_time, presence: true, :on_or_after => lambda { Date.current } ,:on_or_after_message => " no debe ser menor a la actual"
  validates :name, presence: true


  private

  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end
end
