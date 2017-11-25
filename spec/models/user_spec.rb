require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'valid' do
    subject(:user) do
      User.new(name: name, email: email, password: password)
    end
    let(:name) { '名前' }
    let(:email) { 'test@example.com' }
    let(:password) { 'P@ssw0rd' }

    it { is_expected.to be_valid }
  end
end
