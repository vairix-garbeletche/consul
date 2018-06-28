module FollowsHelper

  def follow_text(followable)
    entity = followable.class.name.underscore
    if entity == 'proposal' && !followable.is_proposal
      t('shared.follow_entity', entity: t("activerecord.models.legislation_proposal.one").downcase)
    else
      t('shared.follow_entity', entity: t("activerecord.models.#{entity}.one").downcase)
    end
  end

  def unfollow_text(followable)
    if followable.class.name.underscore == 'proposal' && !followable.is_proposal
      entity = 'legislation_proposal'
    else
      entity = followable.class.name.underscore
    end
    t('shared.unfollow_entity', entity: t("activerecord.models.#{entity}.one").downcase)
  end

end
