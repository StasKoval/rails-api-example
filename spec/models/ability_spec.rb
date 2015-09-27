require 'rails_helper'

describe User do
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "user can create article" do
      context "when user is admin" do
        let(:user) { FactoryGirl.create(:user, role: :admin) }

        it { is_expected.to be_able_to(:manage, Article) }
      end
    end

    context "user cannot create article" do
      context "when user is plain user" do
        let(:user) { FactoryGirl.create(:user, role: :user) }

        it { is_expected.not_to be_able_to(:manage, Article) }
      end
    end
  end
end
