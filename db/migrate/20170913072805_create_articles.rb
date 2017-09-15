class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :name,    null: false, default: ""           #お店の名前
      t.string  :address, null: false, default: ""           #お店の住所
      t.string  :tell                                        #お店の電話番号
      t.string  :picture                                     #お店の写真
      t.integer :genre,   default: 0                         #お店のジャンル(Enum)
      t.integer :parking, default: 0                         #駐車場あるかないか(一応Enumで)
      t.text    :station                                     #最寄り駅(いずれ別テーブルに)
      t.text    :art_comment                                 #コメント
      t.text    :source                                      #情報の出どころ
      t.integer :user_id                                     #UserID
      #t.integer :evaluate_id                                #評価IDは削除
      t.timestamps null: false
    end
  end
end
