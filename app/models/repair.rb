class Repair < ActiveRecord::Base
  has_many :instruments
  has_many :accessories

end
