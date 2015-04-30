class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :dns_name
      t.string :private_dns_name
      t.string :private_ip_address
      t.string :public_ip_address
      t.text :puppet_config

      t.timestamps null: false
    end
  end
end
