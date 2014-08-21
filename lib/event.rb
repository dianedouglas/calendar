class Event < ActiveRecord::Base

  scope :future_events, -> { where("start_date > ?", Time.now)}

end
