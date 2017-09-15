class Article < ActiveRecord::Base
  belongs_to :user
  has_many :evaluates, dependent: :destroy
end
