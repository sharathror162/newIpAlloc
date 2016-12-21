class AddUserIdToDevices < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :user_id, :integer
  end
end
