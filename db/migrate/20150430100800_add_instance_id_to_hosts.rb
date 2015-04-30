class AddInstanceIdToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :instance_id, :string
    add_index :hosts, :instance_id, unique: true
  end
end
