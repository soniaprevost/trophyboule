class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :games, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def self.find_for_google_oauth2(auth)
    credentials = auth.credentials
    data = auth.info
    user = User.where(email: data["email"]).first

    unless user
     user = User.create(
        name: data["name"],
        picture: data["image"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        token: credentials.token,
        token_expiry: credentials.refresh_token
     )
    end
    user
  end
end
