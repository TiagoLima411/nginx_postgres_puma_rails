class IncomesController < ApplicationController
  before_action :authenticate_user!
  # TODO - polices
  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to dashboard_path, notice: 'Depósito efetuado com sucesso.' }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def income_params
    params.require(:income).permit(:id, :user_id, :intype, :value, :description)
  end

end
