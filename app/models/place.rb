class Place < ApplicationRecord
  mount_uploader :facility_maps, FacilityMapsUploader
  validates :address, presence: true
  validates :facility_maps, presence: true
  has_many :comments

  belongs_to :user
end
