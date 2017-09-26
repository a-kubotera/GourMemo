@user.articles.each do |article|
   unless article.evaluates.where(user_id: article.user_info.id)
 end
 a = []
 b = []
 a = @user.articles.map{|article| article.evaluates.where(user_id: article.user_info.id).blank? ? a << article : b << article}
