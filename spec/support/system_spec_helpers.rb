module SystemSpecHelpers
  def sign_in(user)
    Rails.application.env_config["omniauth.auth"] = github_mock(user)
    visit root_path
    click_link "ログイン"
  end
end
