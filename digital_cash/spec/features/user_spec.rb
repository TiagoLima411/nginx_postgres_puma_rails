require 'rails_helper'
# require 'rspec/rails'

RSpec.feature 'Register User', type: :feature, js: true do
  scenario 'Check Registration Form' do
    visit(account_register_path)

    # print page.html
    # save_and_open_page

    expect(page).to have_content('Crie seu Acesso')
    expect(page).to have_selector("input[type=text][name='member[user_attributes][username]']")
    expect(page).to have_selector("input[name='member[user_attributes][password]']")
    expect(page).to have_selector("input[name='member[user_attributes][password_confirmation]']")
    expect(page).to have_selector("input[name='member[name]']")
    expect(page).to have_selector("input[type=email][name='member[email]']")
    expect(page).to have_selector("input[type=text][name='member[phone]']")
    expect(page).to have_selector("input[type=text][name='member[birthday]']")
    expect(page).to have_selector("select[name='member[gender]']")
    expect(page).to have_selector("input[name='member[cpf]']")
    expect(page).to have_selector("input[name='member[mother_name]']")
    expect(page).to have_selector("input[name='member[rg]']")
    expect(page).to have_selector("input[name='member[zipcode]']")
    expect(page).to have_selector("input[name='member[address]']")
    expect(page).to have_selector("input[name='member[address_number]']")
    expect(page).to have_selector("input[name='member[district]']")
    expect(page).to have_selector("input[name='member[complement]']")

    expect(page).to have_selector("input[type=submit][value='Criar Conta']")
  end

  # scenario 'Verify User Registration' do
    # visit(account_register_path)

    # password = '123456'

    # fill_in('member[user_attributes][username]', with: 'Joao')
    # fill_in('member[user_attributes][password]', with: password)
    # fill_in('member[user_attributes][password_confirmation]', with: password)
    # fill_in('member[name]', with: 'Joao da Silva')
    # fill_in('member[email]', with: Faker::Internet.email)
    # fill_in('member[phone]', with: Faker::PhoneNumber.cell_phone)
    # fill_in('member[birthday]', with: Faker::Date.birthday)
    # find('#member_gender').find(:xpath, 'option[2]').select_option
    # fill_in('member[cpf]', with: Faker::CPF.pretty)
    # fill_in('member[mother_name]', with: Faker::Name.feminine_name)
    # fill_in('member[rg]', with: Faker::Number.number(digits = 10))
    # fill_in('member[zipcode]', with: '57084-040')
    # fill_in('member[address]', with: Faker::Address.full_address)
    # fill_in('member[address_number]', with: Faker::Address.building_number)
    # fill_in('member[district]', with: Faker::Address.street_address)
    # fill_in('member[complement]', with: '')

    # page.execute_script("
    #   let select = document.getElementById('cbbState');
    #   select.innerHTML = '';
    #   let option = document.createElement('option');
    #   option.value = 2;
    #   option.text  = 'Alagoas';
    #   select.appendChild(option);
    # ")

    # find('#cbbState').find(:xpath, 'option[1]').select_option
    # find('#cbbCity').find(:xpath, 'option[1]').select_option

    # click_on('Criar Conta')
    # expect(page).to have_content('Bem-vindo')
  #end

  # scenario 'Checks Error in registration' do
  #   visit(account_register_path)
  #   click_on('Criar Conta')
  #   expect(page).to have_content('Username não pode ficar em branco')
  # end

end
