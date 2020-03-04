source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.4"

gem "bootsnap", ">= 1.4.2", require: false
gem "jbuilder", "~> 2.7"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 3.12"
gem "rails", "~> 6.0.0"
gem "sass-rails", "~> 5"
gem "slim-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

# Authentication
gem "omniauth-github"

# Model
gem "enum_help"

# View
gem "coderay"
gem "redcarpet"

# Image
gem "carrierwave"
gem "mini_magick"

group :development, :test do
  gem "bullet"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
