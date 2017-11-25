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

    describe 'name' do
      context '空の場合' do
        let(:name) { '' }
        it { is_expected.not_to be_valid }
      end
      context '長さ境界値超の場合' do
        let(:name) { 'a' * 51 }
        it { is_expected.not_to be_valid }
      end
    end

    describe 'email' do
      context '空の場合' do
        let(:email) { '' }
        it { is_expected.not_to be_valid }
      end
      context '長さ境界値超の場合' do
        let(:email) { 'a' * 244 + '@example.com' }
        it { is_expected.not_to be_valid }
      end
      context 'emailフォーマットの場合' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                            first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          let(:email) { valid_address }
          it { is_expected.to be_valid }
        end
      end
      context 'emailフォーマットでない場合' do
        valid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
        valid_addresses.each do |valid_address|
          let(:email) { valid_address }
          it { is_expected.not_to be_valid }
        end
      end
      context 'emailがuniqueでない場合' do
        it 'バリデーションエラー' do
          duplicate_user = subject.dup
          subject.save
          expect(duplicate_user).not_to be_valid
        end
      end
      context '大文字の場合' do
        let(:email) { 'Hoge@FUGA.CoM' }
        it '小文字変換される' do
          user.save
          expect(email.downcase).to eq(user.reload.email) 
        end
      end
    end
  end
end
