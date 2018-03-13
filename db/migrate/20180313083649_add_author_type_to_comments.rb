class AddAuthorTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_type, :integer, default: 0
    add_column :proposals, :author_type, :integer, default: 0
  end
end
