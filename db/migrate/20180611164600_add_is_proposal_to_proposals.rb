class AddIsProposalToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :is_proposal, :bool, default: true
  end
end
