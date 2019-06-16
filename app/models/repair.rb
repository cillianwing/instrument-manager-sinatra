class Repair < ActiveRecord::Base
  has_one :instrument
  has_one :accessories
  belongs_to :user

end
