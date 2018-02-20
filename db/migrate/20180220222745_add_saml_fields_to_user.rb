class AddSamlFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: true
    add_column :users, :last_name, :string, null: true
    add_column :users, :second_surname, :string, null: true
    add_column :users, :certificated, :boolean, null: true
    add_column :users, :document_country, :string, null: true
    add_column :users, :document_type, :string, null: true
    add_column :users, :in_place, :string, null: true
  end
end
