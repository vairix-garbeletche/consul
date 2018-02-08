namespace :set_proposal_dates do

  desc "Set initials modules"
  task set_dates: :environment do
    if Setting['proposals_start_date']
      Setting['proposals_start_date'] = Date.today - 20.days
    else
      Setting.create(key: 'proposals_start_date', value: Date.today - 20.days)
    end
    if Setting['proposals_end_date']
      Setting['proposals_end_date'] = Date.today + 100.days
    else
      Setting.create(key: 'proposals_end_date', value: Date.today + 100.days)
    end

  end

end
