class V1::HostSerializer < ActiveModel::Serializer
  # Attributes
  attributes :id, :instance_id, :dns_name, :private_dns_name,
             :private_ip_address, :public_ip_address, :puppet_config
end
