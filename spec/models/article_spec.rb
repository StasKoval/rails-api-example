require 'rails_helper'

describe Article do
  describe "database" do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe "relations" do
    it { is_expected.to belong_to(:user) }
  end
end
