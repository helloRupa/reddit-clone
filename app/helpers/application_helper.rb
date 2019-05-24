module ApplicationHelper
  def url_preview(object)
    object.url && object.url.length > 3 ? Onebox.preview(h(object.url)).to_s.html_safe : nil
  end

  def url_link(object)
    object.url ? link_to(h(object.url), h(object.url), target: "_blank") : nil
  end
end
