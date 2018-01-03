module ViewHelper
  def article_delete_massage(article)
    @deleteWarning = "本当にこの記事を削除してもよろしいでしょうか？<br>"
    if article.evaluates.count > 0 || article.likes.count > 0
      @deleteWarning +="この記事は<p class='text-danger'>"
        if article.likes.count> 0
          @deleteWarning +="● #{article.likes.count}人が注目しています。<br>"
        end
        if article.evaluates.count > 0
          @deleteWarning +="● #{article.evaluates.count}人が評価しています。<br>"
        end
        @deleteWarning +="<br>記事を削除すると、これらの情報も一緒に消えてしまいます。</p>"
    end
    @deleteWarning += "確認のため下記の文字列を入力してください。
                      <p class='well well-sm'>#{@CAPTCHA = (0...8).map{ (65 + rand(26)).chr }.join}</p>"
    return [@deleteWarning,@CAPTCHA]
  end
end
