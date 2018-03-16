class AddTermsOfServiceToUser < ActiveRecord::Migration
  def change
    add_column :users, :terms_of_service, :bool
  end
end
