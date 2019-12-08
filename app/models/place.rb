class Place < ApplicationRecord
  mount_uploader :facility_maps, FacilityMapsUploader
  validates :address, presence: true

  belongs_to :user
end
