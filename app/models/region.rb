class Region < ApplicationRecord
  has_many :wineries, :dependent => :delete_all

  validates :name, presence: true, uniqueness: true

end
