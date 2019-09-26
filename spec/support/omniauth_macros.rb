module OmniauthMacros
  def github_mock(user = nil)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {
        provider: "github",
        uid: user&.uid || Faker::Number.number(digits: 13),
        info: {
          nickname: user&.name || Faker::Internet.username,
          name: user&.display_name || Faker::Name.name,
          email: user&.email || Faker::Internet.safe_email,
          image: Faker::LoremFlickr.image,
        },
        credentials: {
          token: Faker::Internet.device_token,
        },
      }
    )
  end
end
