require 'rails_helper'

feature "Sign In", type: :feature do
  scenario 'Check Login Form' do
    visit(new_user_session_path)
    expect(page).to have_content('Bem-vindo')
    expect(page).to have_selector("input[type=text][name='user[username]']")
    expect(page).to have_selector("input[type=password][name='user[password]']")
    expect(page).to have_selector("input[type=submit][value=Login]")
    expect(page).to have_link('Cadastre-se agora!')
  end

  scenario 'Check Link Create Account' do
    visit(new_user_session_path)
    click_on('Cadastre-se agora!')
    expect(page).to have_current_path(account_register_path)
  end

  scenario 'Check Error On Login' do
    visit(new_user_session_path)

    fill_in('user[username]', with: Faker::Internet.username)
    fill_in('user[password]', with: Faker::Internet.password)

    click_on('Login')
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('Informe username e senha corretamente.')
  end
end
