class City < ApplicationRecord
  belongs_to :state

  def self.generate(id, state_id, name, capital, created_at = nil, updated_at = nil)
    city = City.new
    city.id = id
    city.state_id = state_id
    city.name = name
    city.capital = capital
    city.created_at = created_at.nil? ? Time.now : created_at
    city.updated_at = updated_at.nil? ? Time.now : updated_at
    city.save
  end
end
