namespace :dev do
  desc 'Inicializa o ambiente'
  task init: :environment do
    puts 'Iniciando o ambiente de desenvolvimento.'
    puts '==============================================='
    puts "Criando o usuário root [ ]\n\nrails dev:root"
    puts `rails dev:root`.to_s
    puts 'Usuário root criado [X]'
    puts '==============================================='
    puts "Criando os response codes [ ]\n\nrails dev:response_codes"
    puts `rails dev:response_codes`.to_s
    puts 'Response codes criados [X]'
    puts '==============================================='
    puts "Criando os planos padrões [ ]\n\nrails dev:plans"
    puts `rails dev:plans`.to_s
    puts 'Planos criados [X]'
    puts '==============================================='
    puts "Cria os tipos de maquinetas padrões [ ]\n\nrails dev:machine_types"
    puts `rails dev:machine_types`.to_s
    puts 'Tipos de maquinetas criados [X]'
    puts '==============================================='
    puts "Cria os segmentos padrões [ ]\n\nrails dev:segments"
    puts `rails dev:segments`.to_s
    puts 'Segmentos criados [X]'
  end

  desc 'Cria o usuário root'
  task root: :environment do
    member = Member.create!(name: 'OnPax Root', email: 'root@onpax.com.br', cpf: '085.067.834-02', state_id: 2, city_id: 69)
    User.create!(
      username: 'onpaxroot',
      name: 'Root User',
      member: member,
      password: '123123123',
      password_confirmation: '123123123',
      role: :root
    )
  end

  desc 'Cria os reponse codes'
  task response_codes: :environment do
    ResponseCode.create!(code: '0', message: 'Aprovada')
    ResponseCode.create!(code: '1', message: 'Negada')
    ResponseCode.create!(code: '2', message: 'Negada por duplicidade ou fraude')
    ResponseCode.create!(code: '5', message: 'Em revisão (análise manual de fraude)')
    ResponseCode.create!(code: '1022', message: 'Erro na operadora do cartão')
    ResponseCode.create!(code: '1024', message: 'Erro nos parâmetros enviados')
    ResponseCode.create!(code: '1025', message: 'Erro nas credenciais')
    ResponseCode.create!(code: '2048', message: 'Erro interno')
    ResponseCode.create!(code: '4097', message: 'Timeout com a adquirente')
  end

  desc 'Cria os planos padrões'
  task plans: :environment do
    Plan.create!(name: 'Plano Anual - R$ 669,90', value: 669.90, qtd_premium_days: 365)
    Plan.create!(name: 'Plano Mensal - R$ 69,90', value: 69.90, qtd_premium_days: 30)
  end

  desc 'Cria os tipos de maquinetas padrões'
  task machine_types: :environment do
    MachineType.create!(name: 'Parceirinha Top - R$ 999,90', value: 999.90)
    MachineType.create!(name: 'Parceirinha Mini - R$ 699,90', value: 699.90)
  end

  desc 'Cria os segmentos padrões'
  task segments: :environment do
    Segment.create!(name: 'Clínicas, laboratórios, serviços de saúde')
    Segment.create!(name: 'Cia. Aérea')
    Segment.create!(name: 'Comércio Varejista')
    Segment.create!(name: 'Comércio Atacadista')
    Segment.create!(name: 'Cultura e Entretenimento')
    Segment.create!(name: 'Cursos, Escolas e universidades')
    Segment.create!(name: 'Eletrônicos e informática')
    Segment.create!(name: 'Farmácias')
    Segment.create!(name: 'Hotéis')
    Segment.create!(name: 'Indústria')
    Segment.create!(name: 'Joalherias')
    Segment.create!(name: 'Locadoras')
    Segment.create!(name: 'Lojas de Departamentos')
    Segment.create!(name: 'Lojas de Conveniência')
    Segment.create!(name: 'Lojas de Veículos')
    Segment.create!(name: 'Materiais de Construção')
    Segment.create!(name: 'Mercados e Supermercados')
    Segment.create!(name: 'Móveis e Decoração')
    Segment.create!(name: 'Padaria')
    Segment.create!(name: 'Vestuário, Roupas e Calçados')
    Segment.create!(name: 'Posto de combustível')
    Segment.create!(name: 'Profissional Autônomo')
    Segment.create!(name: 'Restaurante, Fastfood, Lanchonetes')
    Segment.create!(name: 'Representante Comercial')
    Segment.create!(name: 'Salão de Beleza')
    Segment.create!(name: 'Serviços Automotivos')
    Segment.create!(name: 'Som e Acessórios')
    Segment.create!(name: 'Serviços Diversos')
    Segment.create!(name: 'Transportes')
    Segment.create!(name: 'Outros')
  end
end
