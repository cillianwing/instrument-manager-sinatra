class User < ActiveRecord::Base
  has_secure_password

  has_many :instruments
  has_many :accessories
  has_many :repairs
end
