require 'rails_helper'

RSpec.describe PuppetClass, type: :model do

  # attributes
  it { should have_db_column :name }

  # validations
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }

end
