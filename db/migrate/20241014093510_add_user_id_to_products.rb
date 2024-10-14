class AddUserIdToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :user_id, :integer
  end
end
