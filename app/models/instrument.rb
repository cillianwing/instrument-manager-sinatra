class Instrument < ActiveRecord::Base
  has_many :instrument_accessories
  has_many :accessories, through: :instrument_accessories
  belongs_to :user
  belongs_to :repair
end
