require 'rails_helper'

feature "Recharge", type: :feature do
  before do
    @user = create(:user)
    @member = create(:member)
    @user.member = @member
  end

  scenario 'Check Recharge Form' do
    login_as(@user, scope: :user)
    visit(new_recharge_path)
    expect(page).to have_content('Recarga em Conta')
    expect(page).to have_selector("input[type=text][id='amount']")
    expect(page).to have_selector("input[type=text][id='card_cvv']")
    expect(page).to have_selector("input[type=text][id='card_expiration_month']")
    expect(page).to have_selector("input[type=text][id='card_expiration_year']")
  end

  scenario 'Check Error On Login' do
    login_as(@user, scope: :user)
    visit(new_recharge_path)

    fill_in('amount', with: '10,00')
    fill_in('card_number', with: '4111111111111111')
    fill_in('card_cvv', with: '123')
    fill_in('card_expiration_month', with: '12')
    fill_in('card_expiration_month', with: '12')

    click_on('Recarregar')
    #binding.pry
    #expect(page).to have_current_path(account_extracts_path)
    #expect(page).to have_content('Extrato Financeiro')
  end
end
