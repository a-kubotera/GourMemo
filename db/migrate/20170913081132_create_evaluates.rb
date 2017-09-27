class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.datetime :date                 #評価した日
      t.integer  :evaluate    ,null: false, default: 0         #評価（ポイント制）
      t.text     :eva_comment                                   #コメント
      t.integer  :user_id       ,null: false                                #評価者
      t.integer  :article_id    ,null: false                               #記事ID
      t.timestamps null: false
    end
    add_index :evaluates, [:user_id, :article_id], unique: true
  end
end
