class Identity < ActiveRecord::Base
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  SAML_PROVIDER = 'saml'

  def self.first_or_create_from_oauth(auth)
    if auth.provider == SAML_PROVIDER
      uid = auth.extra.raw_info.attributes["uid"][0]
      if uid.include?('uy-dni')
        uid = uid.split('uy-dni-')[1]
      end
      where(uid: uid, provider: auth.provider).first_or_create
    else
      where(uid: auth.uid, provider: auth.provider).first_or_create
    end
  end
end
