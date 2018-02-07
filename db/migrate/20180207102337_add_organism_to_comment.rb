class AddOrganismToComment < ActiveRecord::Migration
  def change
    add_column :comments, :organism, :string
  end
end
