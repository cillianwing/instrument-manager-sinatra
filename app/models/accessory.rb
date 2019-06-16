class Accessory < ActiveRecord::Base
  has_many :instrument_accessories
  has_many :instruments, through: :instrument_accessories
  belongs_to :user
  belongs_to :repair
end
