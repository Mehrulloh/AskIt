class UserDecorator < ApplicationDecorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@')[0].lowercase
  end

  def gravatar(size: 30, css_class: '')
    email_hash = Digest::MD5.hexdigest email.strip.downcase

    h.image_tag "http://secure.gravatar.com/avatar/#{email_hash}?s=#{size}",
       alt: name_or_email, class: "rounded #{css_class}"
  end
end
