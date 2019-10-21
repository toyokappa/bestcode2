require "reform/form/validation/unique_validator"

class UserForm < ApplicationForm
  include NestedChildPopulator

  property :name
  property :display_name
  property :image
  property :image_cache
  property :email
  property :introduction
  property :url

  collection :resumes, form: ResumeForm, populator: :nested_child_populator

  # FIXME: CarrierWaveを使用していることでcopy_validations_fromが使用できない。
  #        冗長ではあるがモデルと同様のバリデーションを設定せざるを得ない。
  #        もう少し良い実装方法が見つかった際は書き換えたい。
  URL_FMT = /\A#{URI.regexp(%w[http https])}\z/.freeze
  validates :name, presence: true, unique: { case_sensitive: false }
  validates :display_name, presence: true
  validates :url, format: { with: URL_FMT, allow_blank: true }
  validates :image, file_size: { less_than: 10.megabytes }, file_content_type: { allow: %w[image/jpeg image/png image/gif] }
end
