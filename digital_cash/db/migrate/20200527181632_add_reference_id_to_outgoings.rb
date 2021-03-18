class AddReferenceIdToOutgoings < ActiveRecord::Migration[5.0]
  def change
    add_column :outgoings, :reference_id, :integer, after: :outtype
  end
end
