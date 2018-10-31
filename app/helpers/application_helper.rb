module ApplicationHelper
  def flash_messages(f)
    translate_name = { notice: 'success', alert: 'danger' }

    f.map { |name, msg|
      content_tag(:div, h(msg), class: "alert alert-#{translate_name[name.to_sym]}")
    }.join("\n")
  end
end
