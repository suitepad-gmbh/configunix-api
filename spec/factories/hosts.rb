FactoryGirl.define do
  factory :host do
    sequence(:instance_id) { |n| 'instance#%02d'%[n] }
    sequence(:name)     { |n| 'Name %02d'%[n] }
    dns_name            { [public_ip_address.gsub('.', '-'), FFaker::Internet.domain_name].join '.' }
    private_dns_name    { [private_ip_address.gsub('.', '-'), FFaker::Internet.domain_name].join '.' }
    private_ip_address  { FFaker::Internet.ip_v4_address }
    public_ip_address   { FFaker::Internet.ip_v4_address }
    puppet_config       "classes:\n- admins\n"
  end
end
