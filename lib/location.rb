class Location < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :event
  before_save :fix_name

  private

  def fix_name
    self.name = self.name.capitalize
  end

end
