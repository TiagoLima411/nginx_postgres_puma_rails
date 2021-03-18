class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @account_balance = current_user.account_balance.available_value_cents
    
    @amount_income_value_cents = current_user.incomes.sum('value_cents')
    @amount_outgoing_value_cents = current_user.outgoings.sum('value_cents')
    
    @amoun_volume_traded = @amount_income_value_cents + @amount_outgoing_value_cents
    @amoun_volume = @amoun_volume_traded
    @amoun_volume_traded = 1 if @amoun_volume_traded.eql?(0)

    @percent_incomes =  (@amount_income_value_cents * 100) / @amoun_volume_traded 
    @percent_outgoings = (@amount_outgoing_value_cents * 100) / @amoun_volume_traded

  end

  def get_volume_traded_by_month
    date = Date.today - 3.month
    arr = []
    while date <= Date.today
        i = date
        
        amount_incomes = current_user.incomes.incomes_in_month(date).sum(:value_cents).to_f / 100
        amount_outgoings = current_user.outgoings.outgoings_in_month(date).sum(:value_cents).to_f / 100
        
        obj = { 
          month: "#{I18n.t('date.abbr_month_names')[i.month]} #{i.year}",
          income: (amount_incomes), 
          outgoing: (amount_outgoings)
        }
        arr << obj
        date = date + 1.month
    end
    json_response(arr)
  end

end
