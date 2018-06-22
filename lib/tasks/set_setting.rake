namespace :set_setting do

  desc "Set settings data"
  task set_data: :environment do
    setting = Setting.find_by_key 'proposals_require_admin'
    if setting.blank?
      Setting['proposals_require_admin'] = nil
    end
    setting = Setting.find_by_key 'auto_publish_comments'
    if setting.blank?
      Setting['auto_publish_comments'] = "true"
    end
    setting = Setting.find_by_key 'proposals_start_date'
    if setting.blank?
      Setting['proposals_start_date'] = Date.today - 20.days
    end
    setting = Setting.find_by_key 'proposals_end_date'
    if setting.blank?
      Setting['proposals_end_date'] = Date.today + 100.days
    end
    Setting['mailer_from_name'] = 'Gobierno Abierto'
    Setting['mailer_from_address'] = 'gobiernoabierto@agesic.gub.uy'
    if User.where(email: 'jose.poncedeleon@agesic.gub.uy').empty?
      pass = SecureRandom.hex(8)
      admin = User.create!(username: 'jose.poncedeleon', email: 'jose.poncedeleon@agesic.gub.uy', password: pass, password_confirmation: pass, confirmed_at: Time.current, terms_of_service: "1")
      admin.residence_verified_at = Date.today
      admin.level_two_verified_at = Date.today
      admin.save
      admin.create_administrator
    end
    Setting["meta_title"] = '4to Plan de Acción Nacional 2018 - 2020'
    Setting["meta_description"] = 'Proponé y participa: Podés presentar propuestas y hacer comentarios hasta el 17 de junio de 2018. Proponé ideas o iniciativas que fortalezcan la transparencia, el acceso a la información pública, la rendición de cuentas, la participación y la colaboración ciudadana.'
    Setting["meta_keywords"] = "4to Plan de Acción Nacional"
  end

  desc "set data home"
  task set_data_home: :environment do
    Setting["title_home"] = "Proponé y participá"
    Setting["sub_title_home"] = "Podés presentar propuestas y hacer comentarios hasta el 30 de junio de 2018."
    Setting["description_home"] = "Proponé ideas o iniciativas que fortalezcan la transparencia, el acceso a la información pública, la rendición de cuentas, la participación y la colaboración ciudadana."
    Setting["title_link_home"] = "Ver propuestas"
    Setting["url_link_home"] = "http://localhost:3000/proposals"
  end

  desc "set data legislation proposal"
  task set_data_legislation_proposal: :environment do
    Setting.create(key: 'max_votes_for_legislation_proposal_edit', value: '1000')
    Setting.create(key: 'votes_for_legislation_proposal_success', value: '100')
    setting = Setting.find_by_key 'legislation_proposals_start_date'
    if setting.blank?
      Setting['legislation_proposals_start_date'] = Date.today - 20.days
    end
    setting = Setting.find_by_key 'legislation_proposals_end_date'
    if setting.blank?
      Setting['legislation_proposals_end_date'] = Date.today + 100.days
    end
  end

end
