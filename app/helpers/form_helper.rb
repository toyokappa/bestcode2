module FormHelper
  # JSでフォームフィールドを追加するためのHTMLと仮のindexのハッシュを返す
  def additional_field_data(form: , children:, index: Time.zone.now.to_i)
    child = form.object.send(children).new
    field = form.fields_for(children, child, child_index: index) do |f|
      render("#{children.to_s.singularize}_field", f: f)
    end
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
