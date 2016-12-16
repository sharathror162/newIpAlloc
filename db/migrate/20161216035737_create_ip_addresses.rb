class CreateIpAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :ip_addresses do |t|
      t.string :ip_value
      t.integer :device_id
      t.belongs_to :device, index: true

      t.timestamps
    end
  end
end
