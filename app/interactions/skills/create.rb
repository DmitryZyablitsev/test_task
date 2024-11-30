class Skills::Create < ActiveInteraction::Base
  string :name
  object :user, default: nil

  validates :name, presence: true

  def execute
    skill = Skill.find_or_create_by(name: name)
    skill.users << user if user
    skill
  end
end
