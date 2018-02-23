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
  end
end
