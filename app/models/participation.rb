class Participation < ApplicationRecord
  belongs_to :event
  has_many :attendees, class_name: "User", foreign_key: "user_id", dependent: :destroy
end
