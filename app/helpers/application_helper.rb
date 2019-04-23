module ApplicationHelper
  def responsive_image_tag path, opts, tag_opts
    "<img alt='#{tag_opts[:alt]}' style='#{tag_opts[:style]}' class='#{tag_opts[:class]}' srcset='#{[1, 1.5, 2, 3].map {|x| ix_image_url(path, opts.merge({dpr: x})) + " #{x}x"}.join(', ') }' src='#{ix_image_url(path, {h: 50, fit: 'clip'})}'/>".html_safe
  end
end
