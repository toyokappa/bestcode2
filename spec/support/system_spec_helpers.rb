module SystemSpecHelpers
  def sign_in(user)
    Rails.application.env_config["omniauth.auth"] = github_mock(user)
    visit root_path
    click_link "ログイン"
    sleep 0.1 # ログインするまでにラグがあるため調整
  end

  def sign_out
    find("#headerNavDropdown").click # ドロップダウン
    click_link "ログアウト"
  end
end
