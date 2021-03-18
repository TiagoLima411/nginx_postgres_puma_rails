class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :member_change_password, :set_payment_password]
  before_action :set_member, only: %i[update]
  before_action :authenticate_user!, except: %i[ register create site]
  layout :resolve_layout

  def register
    @member = Member.new
    @member.user = User.new
  end

  def edit
    @member = current_user.member
  end
  
  def member_change_password
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]

    user = current_user

    if user.valid_password?(password)
      user.password = new_password
      user.password_confirmation = new_password_confirmation
      user.save
      sign_in(current_user, :bypass => true)
      flash[:success] = "Senha alterada com sucesso."
      redirect_to account_edit_path
    else
      flash[:warning] = "A senha atual digitada está diferente."
      redirect_to account_edit_path
    end
  end
  
  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    @member.user.username.strip!
    @member.user.username.downcase!
    @member.user.role = :member
    #@member.state_id = @member.city.state_id
      
    respond_to do |format|
      if @member.valid? && @member.user.valid?
        @member.save

        session[:member_success] = "Cadastro realizado com sucesso!"
        format.html {
          redirect_to '/dashboard' unless current_user.nil?
          redirect_to new_user_session_path if current_user.nil?
        }
      else
        session[:member_errors] = []
        if @member.errors.any?
          @member.errors.full_messages.each do |member_msg|
            unless member_msg.include? 'Users'
              session[:member_errors] << member_msg
            end
          end
        end
        if @member.user.errors.any?
          @member.user.errors.full_messages.each do |user_msg|
            unless user_msg.include? 'Member'
              session[:member_errors].push(user_msg)
            end
          end
        end
        session[:member_errors] = "Cadastro não pode ser realizado."
        format.html { render :register }
      end
    end
  end

  
  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        user = User.find_by(member_id: @member.id)
        format.html { flash[:success] = "Dados atualizados com sucesso."
        redirect_to '/dashboard' }
      else
        format.html { render :edit }
      end
    end
  end

  def set_payment_password
    
    if params[:payment_password].present? && params[:payment_password_confirmation].present? && params[:payment_password].eql?(params[:payment_password_confirmation])

      if current_user.set_payment_password(params[:payment_password])

        #sign_in(current_user, :bypass => true)
        flash[:success] = "Senha de pagamento criada com sucesso."
        redirect_to account_edit_path

      else

        flash[:warning] = "Algo deu errado repita a operação!"
        redirect_to account_edit_path
        
      end
      
    end

  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit( :name, :rg, :mother_name, :gender, :email, :birthday, :cpf, :phone, :cellphone, :address, :zipcode, :city_id, :state_id, :complement, :number, :district, :address_number, :address_reference, user_attributes: %i[id username password password_confirmation member_id])
  end

  def resolve_layout
    case action_name
      when 'register'
        'site'
      when 'create'
        'site'
      when 'site'
        'site'
      else
        'application'
    end
  end
  
  def get_url_base
    if Rails.env.production?
      return 'https://portal.dc.com.br'
    else
      return "http://#{request.host}:#{request.port}"
    end
  end
end
