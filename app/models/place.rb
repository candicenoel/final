class Place < ApplicationRecord
  validates :address, presence: true
end
