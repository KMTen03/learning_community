class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post

  validates :content, length: { maximum: 200 }, presence: true
end
