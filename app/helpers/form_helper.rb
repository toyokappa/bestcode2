module FormHelper
  # JSでフォームフィールドを追加するためのHTMLと仮のindexのハッシュを返す
  def additional_field_data(partial:, index: Time.zone.now.to_i)
    field = render(partial, i: index, resource: nil)
    { html: field.delete("\n"), index: index }
  end
end
