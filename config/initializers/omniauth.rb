Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_ACCESS_KEY"], ENV["TWITTER_SECRET_KEY"], path_prefix: "/users/auth"
end
