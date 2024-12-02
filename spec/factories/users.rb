FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.ru"
  end

  factory :user do
    email
    surname { 'Ivanov' }
    name { 'Roma' }
    patronymic { 'Grigorievich' }
    nationality { 'Russian' }
    country { 'Russia' }
    gender { 'male' }
    age { '25' }
  end
end
