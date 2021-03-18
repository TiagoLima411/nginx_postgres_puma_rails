# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index edit show update]
  before_action :verify_root_access!, only: %i[reset_password]

  def index
  end

  def edit
  end

  def show
  end

  def update;
  end

  def reset_password
    user = User.find(params[:id])
    user.password = '123456'
    user.password_confirmation = '123456'
    user.save
    redirect_to users_path
    flash[:success] = 'Senha alterada com sucesso.'
  end

  private

  def set_user
    @user = current_user
  end

end
