require 'rails_helper'

RSpec.describe RechargesController, type: :controller do
	context 'new recharge' do
		before do
			@user = create(:user)
		end

		it 'responds a 200' do
		  sign_in @user
		  get :new, params: {}
		  expect(response).to have_http_status(200)
		end
	
		it 'render a :new template' do
		  sign_in @user
		  get :new, params: {}
		  expect(response).to render_template(:new)
		end
	end

	context 'create recharge' do
		before do
			@user = create(:user)
		end

		# it 'create a recharge' do
		# 	sign_in @user
		# 	recharge = attributes_for(:recharge)
		# 	recharge[:user_id] = @user.id
		# 	expect{
		# 		post :create, params: { recharge: recharge }
		# 	}.to change(Recharge, :count).by(1)
		# end

		# it 'responds a flash notice success' do
		# 	sign_in @user
		# 	recharge = attributes_for(:recharge)
		# 	recharge[:user_id] = @user.id
		# 	post :create, params: { recharge: recharge }
		# 	expect(flash[:success]).to match('Recarga criada com sucesso.')
		# end

		# it 'content type text/html' do
		# 	sign_in @user
		# 	recharge = attributes_for(:recharge)
		# 	recharge[:user_id] = @user.id
		# 	post :create, params: { recharge: recharge }
		# 	expect(response.content_type).to eq('text/html')
		# end
	
	end

end
