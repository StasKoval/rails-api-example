require 'rails_helper'

describe User do
  describe "database" do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '') }
    it { is_expected.to have_db_column(:role).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:token).of_type(:string) }
  end

  describe "relations" do
    it { is_expected.to have_many(:articles) }
  end

  describe "callbacks" do
    it 'build token before create' do
      expect(FactoryGirl.create(:user).token).not_to be_nil
    end
  end
end
