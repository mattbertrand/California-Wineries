class Winery < ApplicationRecord
  belongs_to :user
  belongs_to :region
  accepts_nested_attributes_for :region, reject_if: :all_blank
  has_many :comments
  has_many :users, through: :comments

  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
  validates :website, presence: true
  validates :phone, presence: true
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "phone number must match this format: 888-888-8888" }

  
  scope :alpha, -> { order(:name) }

end


# def region_attributes=(attr)
#   self.region = Region.find_or_create_by(attr) if !attr[:name].blank?
# end