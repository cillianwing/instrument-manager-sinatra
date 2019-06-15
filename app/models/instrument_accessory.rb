class InstrumentAccessory < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :accessory
end
