class UpdateTagNameLimit < ActiveRecord::Migration
 def up
    execute "ALTER TABLE tags ALTER COLUMN name TYPE VARCHAR(40) USING SUBSTR(name, 1, 80)"
    change_column :tags, :name, :string, limit: 80
  end

  def down
    change_column :tags, :name, :string, limit: nil
  end
end
