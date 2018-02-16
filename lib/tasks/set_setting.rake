namespace :set_setting do

  desc "Set settings data"
  task set_data: :environment do
    setting = Setting.find_by_key 'proposals_require_admin'
    if setting.blank?
      Setting['proposals_require_admin'] = nil
    end
  end
end
