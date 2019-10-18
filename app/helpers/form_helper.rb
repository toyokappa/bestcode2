module FormHelper
  # JSでフォームフィールドを追加するためのHTMLと仮のindexのハッシュを返す
  def additional_field_data(form: f, partial:, index: Time.zone.now.to_i)
    field = render(partial, f: form, i: index, resource: nil)
    { html: field.delete("\n"), index: index }
  end

  # check_box_tagから呼び出して値をboolenで返す
  def checked?(data)
    ActiveRecord::Type::Boolean.new.cast(data)
  end

  # バリデーションに引っかかった際の専用クラスを返す
  def invalid_field_with(form:, field:)
    "is-invalid" if form.object.errors.full_messages_for(field).present?
  end
end
