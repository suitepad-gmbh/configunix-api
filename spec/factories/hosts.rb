FactoryGirl.define do
  factory :host do
    dns_name            { [public_ip_address.gsub('.', '-'), FFaker::Internet.domain_name].join '.' }
    private_dns_name    { [private_ip_address.gsub('.', '-'), FFaker::Internet.domain_name].join '.' }
    private_ip_address  { FFaker::Internet.ip_v4_address }
    public_ip_address   { FFaker::Internet.ip_v4_address }
    puppet_config       "classes:\n- admins\n"
  end
end