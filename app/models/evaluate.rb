class Evaluate < ActiveRecord::Base
  #評価したユーザーの情報を user_infoと呼ぶ
  belongs_to :user_info, class_name: :User, foreign_key: :user_id
  belongs_to :article
end
