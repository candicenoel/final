class Place < ApplicationRecord
  validates :address, presence: true

  belongs_to :user
end
