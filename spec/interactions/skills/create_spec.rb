require 'rails_helper'

RSpec.describe Skills::Create do
  let(:user) { create(:user) }
  let(:valid_name) { 'Swim' }

  describe '#execute' do
    context 'when name is present' do
      it 'creates a new skill if it does not exist' do
        service = described_class.run(name: valid_name)

        expect(service.valid?).to be(true)
        expect(service.result).to be_persisted
        expect(service.result.name).to eq(valid_name)
      end

      it 'does not duplicate interests with the same name' do
        described_class.run(name: valid_name)
        described_class.run(name: valid_name)

        expect(Skill.count).to eq(1)
      end

      it 'associates user with the interest if user is provided' do
        service = described_class.run(name: valid_name, user: user)

        expect(service.valid?).to be(true)
        expect(service.result.users).to include(user)
      end
    end

    context 'when name is missing' do
      it 'is invalid without a name' do
        service = described_class.run(name: nil)

        expect(service.valid?).to be(false)
        expect(service.errors[:name]).to include("is required")
      end
    end


    context 'when user is not provided' do
      it 'creates an interest without associating a user' do
        service = described_class.run(name: valid_name)

        expect(service.valid?).to be(true)
        expect(service.result.users).to be_empty
      end
    end
  end
end
