### Models

- Winery
belongs_to :user
has_many :comments
has_many :users, through: :commments
belongs_to region

name
website
phone number
description:text

- User
has_many wineries
has_many :comments
has_many :commented_wineries, through: :comments
has_many regions, through: :wineries

Username
email
password-digest

- Comment
belongs_to :user
belongs_to :winery

content

- Regions

name

has_many :wineries
has_many :users, through: :wineries