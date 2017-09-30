module ApplicationHelper
  def profile_img(user,avatarSize = "sizeDef")
    return image_tag(user.avatar, alt: user.name,class:avatarSize) if user.avatar?
    if user.image_url.present?
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
      img_url = picture
    end
    image_tag(img_url, alt: name,class:size)
  end

#引数(ID)がログインユーザーの場合だけ、do ~ end　を表示する。
  def login_user?(userid)
    if userid == current_user.id
      yield
    end
  end
  #引数(ID)がログインユーザーの場合だけ、do ~ end　を表示する。
  def not_login_user?(userid)
    unless userid == current_user.id
      yield
    end
  end

  #あなた(LoginUser)がこの記事をLikeしているかどうかの判定
  #@articleは省略可能
  def are_you_like?(article = @article)
    article.liked_users.where(id:current_user.id).present?
  end
  #あなたがすでにこの記事を評価したかどうか？
  def already_evaluated_it?(article = @article)
    article.evaluates.where(user_id:current_user.id).present?
  end
  #この記事はあなたが書いたの？
  def your_article?(article = @article)
    article.user_info.id == current_user.id
  end

  #ユーザーIDを受けて、自分の場合は「あなた」と返す
  def your_name?(user)
    if user.id == current_user.id
      return 'あなた'
    else
      if user.name.brank?
        user.name = 'ゲスト'
      end
      return  user.name + 'さん'
    end
  end
  #evaluateを受け取り、☆で返すViewヘルパー
  def ret_Stars(point)
    #準備中
    #http://cortyuming.hateblo.jp/entry/2017/03/22/131457
    #https://qiita.com/EastResident/items/59856cbc7d8e73138a49

  end

end
