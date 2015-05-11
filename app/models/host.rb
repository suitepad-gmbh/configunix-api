class Host < ActiveRecord::Base

  # Validations
  validates :instance_id, presence: true, uniqueness: true
  validates :dns_name, hostname: { require_fqdn: true }
  validates :private_dns_name, presence: true, hostname: { require_fqdn: true }
  validates :private_ip_address, presence: true, ip_address: true
  validates :public_ip_address, ip_address: true
  validates :puppet_config, yaml: true

end
