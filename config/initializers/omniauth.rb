Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_ACCESS_KEY"], ENV["GITHUB_SECRET_KEY"], path_prefix: "/users/auth", scope: "user"
end
