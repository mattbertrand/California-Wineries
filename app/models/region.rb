class Region < ApplicationRecord
  has_many :wineries, dependent: :nullify
end
