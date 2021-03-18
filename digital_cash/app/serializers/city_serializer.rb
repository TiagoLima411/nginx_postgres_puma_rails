class CitySerializer < ApplicationSerializer
  attributes :id, :name

  belongs_to :state
  class StateSerializer < ActiveModel::Serializer
    attributes :id, :name, :uf
  end
end