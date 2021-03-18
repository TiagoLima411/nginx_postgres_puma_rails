class AccountExtractsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @account_extract = AccountExtract.filter(AccountExtract.user_extract(current_user), params.slice(:type_register, :date_filter_inicial, :date_filter_final))
    @total_available = current_user.account_balance.available_value_cents
    
    if is_defined_param?(:page)
      page = params[:page]
      @account_extract = @account_extract.paginate(page: page, per_page: 10).order(id: :desc)
    else
      @account_extract = @account_extract.paginate(page: 1, per_page: 10).order(id: :desc)
    end
  end
end
