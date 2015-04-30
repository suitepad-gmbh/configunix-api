require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create :user }

  # attributes
  it { should have_attribute :email }
  it { should have_attribute :password }

  # indexes
  it { should have_db_index :email }

  # validations
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of(:email).case_insensitive }

  describe 'password' do
    it 'is encrypted when set' do
      user.password = 'some password'
      expect(user.password).not_to eql 'some password'
    end

    it 'is CRYPT-SHA512 encrypted' do
      user.password = 'some password'
      salt = user.password.split('$')[-2]
      rounds = /rounds=(\d+)/.match(user.password)[1].to_i
      expect(user.password).to eql UnixCrypt::SHA512.build(
        'some password', salt, rounds
      )
    end

    it 'uses 10000 rounds for CRYPT-SHA512' do
      rounds = /rounds=(\d+)/.match(user.password)[1].to_i
      expect(rounds).to eql 10000
    end
  end

  # methods

  describe '#validate_password' do
    it 'succeeds with valid password' do
      user.password = 'my secret password'
      expect(user.validate_password 'my secret password').to be true
    end

    it 'fails with invalid password' do
      user.password = 'my secret password'
      expect(user.validate_password 'wrong password').not_to be true
    end
  end

  describe '#authenticate!' do
    it 'succeeds with valid email and password' do
      user.update_attribute :password, 'password'
      result = User.authenticate!(user.email, 'password')
      expect(result).to eql user
    end

    it 'fails with missing email address' do
      user.update_attribute :password, 'password'
      result = User.authenticate!(user.email + '.com', 'password')
      expect(result).to be nil
    end

    it 'fails with valid email and invalid password' do
      user.update_attribute :password, 'password'
      result = User.authenticate!(user.email, 'wrong password')
      expect(result).to be nil
    end
  end

end
