module ApplicationHelper
  def url_preview(object)
    is_url?(object) ? Onebox.preview(h(object.url)).to_s.html_safe : nil
  end

  def url_link(object)
    is_url?(object) ? link_to(h(object.url), h(object.url), target: "_blank") : nil
  end

  def is_url?(object)
    object.url && object.url.length > 3
  end

  def choose_url_format(object)
    preview = url_preview(object)
    preview && preview.length > 10 ? preview : url_link(object)
  end
end
