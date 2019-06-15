class User < ActiveRecord::Base
  has_many :instruments
  has_many :accessories
  has_secure_password
end
