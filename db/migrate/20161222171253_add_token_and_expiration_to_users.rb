class AddTokenAndExpirationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_token, :string
    add_column :users, :token_expiration, :datetime
  end
end
