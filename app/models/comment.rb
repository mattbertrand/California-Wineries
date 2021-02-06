class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :winery

  validates :content, presence: true
end
