class User < ApplicationRecord
    has_many :wineries
    has_many :comments
    has_many :commented_wineries, through: :comments, source: :winery
    # has_many :regions, through: :wineries
end
