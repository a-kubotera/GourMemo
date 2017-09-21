module ApplicationHelper
  def profile_img(user,avatarSize = "sizeDef")
    return image_tag(user.avatar, alt: user.name,class:avatarSize) if user.avatar?
    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name,class:avatarSize)
  end

  def set_picture(picture,size = "sizeDef",name = "notitle")
    if picture.blank?
      img_url = 'no_image.png'
    else
      img_url = upicture
    end
    image_tag(img_url, alt: name,class:size)
  end

end
