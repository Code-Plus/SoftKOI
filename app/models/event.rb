class Event < ActiveRecord::Base

  include PublicActivity::Model
  tracked only: [:day_of_event]
end
