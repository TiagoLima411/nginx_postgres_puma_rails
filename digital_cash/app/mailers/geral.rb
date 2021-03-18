class Geral < ApplicationMailer

  def wellcome(user, link, email)
    @title = 'Digital Cash - Bem vindo'
    @address = "atendimento@digitalcash.com.br"
    @link = link
    mail(to: email, subject: @title)
  end

end
