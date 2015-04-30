class Host < ActiveRecord::Base

  # Validations
  validates :dns_name, presence: true, hostname: { require_fqdn: true }
  validates :private_dns_name, presence: true, hostname: { require_fqdn: true }
  validates :private_ip_address, presence: true, ip_address: true
  validates :public_ip_address, presence: true, ip_address: true
  validates :puppet_config, yaml: true

end
