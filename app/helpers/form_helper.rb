module FormHelper
  # JSでフォームフィールドを追加するためのHTMLと仮のindexのハッシュを返す
  def additional_field_data(partial:, index: Time.zone.now.to_i)
    field = render(partial, i: index, resource: nil)
    { html: field.delete("\n"), index: index }
  end

  # check_box_tagから呼び出して値をboolenで返す
  def checked?(data)
    ActiveRecord::Type::Boolean.new.cast(data)
  end
end
