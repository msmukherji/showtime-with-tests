class AddStreamColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :stream, :boolean, default: :false
  end
end
