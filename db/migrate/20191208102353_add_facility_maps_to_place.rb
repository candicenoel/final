class AddFacilityMapsToPlace < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :facility_maps, :string
  end
end
