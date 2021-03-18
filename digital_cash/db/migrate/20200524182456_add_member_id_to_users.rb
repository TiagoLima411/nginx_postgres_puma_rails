class AddMemberIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :member, foreign_key: true, after: :active
  end
end
