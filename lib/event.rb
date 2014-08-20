class Event < ActiveRecord::Base

  scope :future_events, -> { where(self.start_date > Time.now)}

end
