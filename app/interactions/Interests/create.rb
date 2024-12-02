class Interests::Create < ActiveInteraction::Base
  string :name
  object :user, default: nil

  validates :name, presence: true

  def execute
    interest = Interest.find_or_create_by(name: name)
    interest.users << user if user
    interest
  end
end
