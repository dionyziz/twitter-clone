require 'spec_helper'

describe "TweetPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "tweet creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not post a tweet" do
        expect { click_button "Tweet" }.not_to change(Tweet, :count)
      end

      describe "error messages" do
        before { click_button "Tweet" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in "tweet_content", with: "Setting up my Twitter" }

      it "should post a tweet" do
        expect { click_button "Tweet" }.to change(Tweet, :count).by(1)
      end
    end
  end

  describe "tweet deletion" do
    before { FactoryGirl.create(:tweet, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a tweet" do
        expect { click_link "delete" }.to change(Tweet, :count).by(-1)
      end
    end
  end
end
