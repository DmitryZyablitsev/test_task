require 'rails_helper'

RSpec.describe Users::Create do
  let(:valid_user_attributes) {
    {
      user: {
        email: 'test@example.com',
        surname: 'Doe',
        name: 'John',
        patronymic: 'Markov',
        nationality: 'American',
        country: 'USA',
        gender: 'male',
        age: 30
      },
      interests: [ 'Programming', 'Music' ],
      skills: [ 'Ruby', 'Rails' ]
    }
  }

  let(:invalid_user_attributes) {
    {
      user: {
        email: 'invalid_email',
        surname: '',
        name: 'Jane',
        patronymic: '',
        nationality: '',
        country: 'USA',
        gender: 'fem',
        age: -5
      },
      interests: [],
      skills: []
    }
  }

  describe '.execute' do
    it 'creates a new user with valid attributes, interests, and skills' do
      user = described_class.run(valid_user_attributes).result

      expect(user).to be_persisted
      expect(User.count).to eq(1)
      expect(user.email).to eq('test@example.com')
      expect(user.interests.map(&:name)).to include('Programming', 'Music')
      expect(user.skills.map(&:name)).to include('Ruby', 'Rails')
    end

    it 'does not create interests if none are provided' do
      user = described_class.run(valid_user_attributes.except(:interests)).result

      expect(user).to be_persisted
      expect(user.interests).to be_empty
      expect(user.skills.map(&:name)).to include('Ruby', 'Rails')
    end

    it 'does not create skills if none are provided' do
      user = described_class.run(valid_user_attributes.except(:skills)).result

      expect(user).to be_persisted
      expect(user.interests.map(&:name)).to include('Programming', 'Music')
      expect(user.skills).to be_empty
    end

    it 'handles case where both interests and skills are empty' do
      user = described_class.run(valid_user_attributes.except(:interests, :skills)).result

      expect(user).to be_persisted
      expect(user.interests).to be_empty
      expect(user.skills).to be_empty
    end

    it 'does not create a user with invalid parameters' do
      invalid_result = described_class.run(invalid_user_attributes)

      expect(invalid_result.valid?).to be_falsey
      expect(User.count).to eq(0)
      expect(invalid_result.errors[:user]).to include("surname must be present", "nationality must be present",
                                                      "email is not valid", "acceptable age range is from 0 to 89",
                                                      "gender should be male or female")
    end
  end
end
