class User < ActiveRecord::Base
  include RedisStorable
  include Authentication

  validates :email, presence: true
  validates :city, presence: true
  validates :name, presence: true
  validates_confirmation_of :password
  validates_uniqueness_of :email


  # def restaurants
  #   Restaurant.all(self.id)
  # end

end
