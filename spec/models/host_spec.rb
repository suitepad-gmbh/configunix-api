require 'rails_helper'

RSpec.describe Host, type: :model do
  let(:host) { FactoryGirl.create :host }
  subject { host }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :dns_name }
  it { should have_attribute :private_dns_name }
  it { should have_attribute :private_ip_address }
  it { should have_attribute :public_ip_address }
  it { should have_attribute :puppet_config }

  ##################################
  # Validations
  ##################################

  it { should validate_presence_of :dns_name }
  it { should validate_presence_of :private_dns_name }
  it { should validate_presence_of :private_ip_address }
  it { should validate_presence_of :public_ip_address }

  it 'validates dns_name to be a valid hostname' do
    subject.dns_name = 'ec2-54-93-200-49.eu-central-1.compute.amazonaws.com'
    expect(subject).to be_valid

    subject.dns_name = 'not_a_domain'
    expect(subject).not_to be_valid
  end

  it 'validates private_dns_name to be a valid hostname' do
    subject.private_dns_name = 'ip-172-31-18-242.eu-central-1.compute.internal'
    expect(subject).to be_valid

    subject.private_dns_name = 'not_a_domain'
    expect(subject).not_to be_valid
  end

  it 'validates private_ip_address to be a valid IP' do
    subject.private_ip_address = '10.0.0.2'
    expect(subject).to be_valid

    subject.private_ip_address ='300.0.0.27'
    expect(subject).not_to be_valid
  end

  it 'validates public_ip_address to be a valid IP' do
    subject.public_ip_address = '10.0.0.2'
    expect(subject).to be_valid

    subject.public_ip_address ='300.0.0.27'
    expect(subject).not_to be_valid
  end

  it 'validates puppet_config to be valid YAML' do
    subject.puppet_config = "classes:\n- admins\n- ntp\n"
    expect(subject).to be_valid

    subject.puppet_config = "Not YAML"
    expect(subject).not_to be_valid
  end

end
