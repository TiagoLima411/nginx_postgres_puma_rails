module ApplicationHelper
  def display_company_menu(company, companies)
    data_activates = companies.size > 1 ? 'dropdown2' : ''
    content_tag(:a, href: '#!', class: 'dropdown-button main-header--menuButton', "data-activates": data_activates) do
      concat(content_tag(:span) do
        company.name
      end)
      if data_activates == 'dropdown2'
        concat(content_tag(:i, class: 'material-icons right') do
          'arrow_drop_down'
        end)
      end
    end
  end

  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def yes_no(value)
    value ? 'Sim' : 'Não'
  end

  def br_date_format(date)
    return date.strftime '%d/%m/%Y' unless date.nil?
  end

  def br_time_format(time)
    return time.strftime '%H:%M' unless time.nil?
  end

  def display_money_without_symbol(value)
    value.to_money.format(symbol: '')
  end

  def display_money(value)
    value.to_money.format(symbol: 'R$ ')
  end

  def display_cent_in_money(value)
    m = (value.to_d / 100).to_money
    m.format(symbol: 'R$ ')
  end

  def display_percent(value)
    number_to_percentage(value, precision: 2)
  end

  def show_month_name(month)
    I18n.t('date.month_names')[month.to_i]
  end

  def months_array_select
    I18n.t('date.month_names').reject(&:nil?).map.with_index do |m, i|
      [m, i + 1]
    end
  end

  def years_array
    return {"2018" => 2018, "2019" => 2019, "2020" => 2020}
  end

  def money_to_points(value)
    value.format.gsub!('R$', '')[0..-4]
  end

  def stores_user(user_id)
    Store.where("user_id IN (?)", user_id)
  end

  def get_extract_point_incentive_request(point_request)
    PointIncentiveExtract.where(point_incentive_request_id: point_request)
  end

  def map_licensed
    if current_user.root?
      User.licensed.order(username: :asc).map { |s| ["#{s.username} - #{s.member.name}", s.id] }
    end
  end

  def map_stores_by_cpf
    if current_user.root?
      Store.where.not(cpf: nil).map { |s| ["#{s.cpf}", s.cpf] }
    else
      Store.where(user_id: current_user.id).where.not(cpf: nil).map { |s| ["#{s.cpf}", s.cpf] }
    end
  end

  def map_stores_by_cnpj
    if current_user.root?
      Store.where("cpf is null or cpf = ? ", "").where.not(cnpj: nil).map { |s| ["#{s.cnpj}", s.cnpj] }
    else
      Store.where(cpf:nil, user_id: current_user.id).where.not(cnpj: nil).map { |s| ["#{s.cnpj}", s.cnpj] }
    end
  end

  def map_stores_by_fantasy_name(active=true)
    if current_user.root?
      Store.where(active: active).map { |s| ["#{s.fantasy_name} - #{s.social_name}", s.id] }
    else
      Store.where(user_id: current_user.id, active: active).where.not(fantasy_name: nil).map { |s| ["#{s.fantasy_name}", s.id] }
    end
  end

  def get_segments
    Segment.all.map { |s| ["#{s.name}", s.id] }
  end

end
