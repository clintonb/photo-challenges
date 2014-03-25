require 'digest/md5'

module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when :success
        'alert-success' # Green
      when :error
        'alert-danger' # Red
      when :alert
        'alert-warning' # Yellow
      when :notice
        'alert-info' # Blue
      else
        flash_type.to_s
    end
  end

  def gravatar_url(user, size=30)
    if user
      hash = Digest::MD5.hexdigest(user.email.downcase)
      "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm"
    end
  end
end
