FactoryBot.define do
  factory :city do
    name { 'Maceió' }

    association :state
  end
end