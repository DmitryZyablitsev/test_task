class Users::Create < ActiveInteraction::Base
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  RANGE_ACCEPTABLE_AGE = 0..90
  ARRAY_GENDERS = %w[male female]

  hash :user do
    string :email, :surname, :name, :patronymic, :nationality, :country, :gender
    integer :age
  end

  array :interests, default: []
  array :skills, default: []

  validate :validate_user_parameters

  def execute
    new_user = User.create(user)

    interests.each do |interest|
      Interests::Create.run(name: interest, user: new_user)
    end

    skills.each do |skill|
      Skills::Create.run(name: skill, user: new_user)
    end

    new_user
  end

  private

  def validate_user_parameters
    required_fields
    validate_email_format
    email_uniqueness
    validate_age
    validate_gender
  end

  def required_fields
    required_fields = [ :email, :surname, :name, :nationality, :country, :age, :gender ]
    required_fields.each do |field|
      errors.add(:user, "#{field} must be present") if user[field].blank?
    end
  end

  def validate_age
    errors.add(:user, "acceptable age range is from 0 to 89") unless RANGE_ACCEPTABLE_AGE.include?(user[:age])
  end

  def validate_gender
    errors.add(:user, "gender should be male or female") unless ARRAY_GENDERS.include?(user[:gender])
  end

  def validate_email_format
    errors.add(:user, "email is not valid") unless user[:email] =~ VALID_EMAIL_REGEX
  end

  def email_uniqueness
    if User.where("LOWER(email) = ?", user[:email].downcase).exists?
      errors.add(:email, "already exists")
    end
  end
end
