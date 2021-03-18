class StatesController < ApplicationController
  def list_state
    states = State.all

    render json: states
  end
end
