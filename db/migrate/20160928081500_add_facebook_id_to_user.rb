class AddFacebookIdToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :facebook_id
    end
  end
end
