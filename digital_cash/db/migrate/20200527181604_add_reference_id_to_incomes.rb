class AddReferenceIdToIncomes < ActiveRecord::Migration[5.0]
  def change
    add_column :incomes, :reference_id, :integer, after: :intype
  end
end
