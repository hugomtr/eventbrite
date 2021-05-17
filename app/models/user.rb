class User < ApplicationRecord
  after_create :welcome_send
  has_many :participations
  has_many :events

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
