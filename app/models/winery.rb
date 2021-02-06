class Winery < ApplicationRecord
  belongs_to :user
  belongs_to :region
  has_many :comments
  has_many :users, through: :comments
  
  scope :alpha, -> { order(:name) }

end


def region_attributes=(attr)
  self.region = Region.find_or_create_by(attr) if !attr[:name].blank?
end