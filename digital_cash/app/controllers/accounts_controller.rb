class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_root_access!, only: %i[index]
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if @account.nil?
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: 'Você ainda não tem uma conta cadastrada.' }
      end
    end
  end

  # GET /accounts/new
  def new
      if current_user.account.nil?
        @account = Account.new
      else
        respond_to do |format|
          format.html { redirect_to dashboard_path, notice: 'Você ja tem uma conta cadastrada.' }
        end
      end
  end

  # GET /accounts/1/edit
  def edit
    if @account.nil?
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: 'Você ainda não tem uma conta cadastrada.' }
      end
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Conta criada com sucesso.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Conta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_account_from_ajax
    @accounts = Account.filter(Account.actives, params.slice(:bank_id, :kind, :agency, :account_number))
    json_response(@accounts, :ok)
  end

  def inactive
    current_user.account.inactive
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Conta desativada com sucesso.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = nil
      @account = current_user.account unless current_user.account.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :bank_id, :agency_number, :account_number, :account_type)
    end
end
