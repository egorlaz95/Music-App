require 'rails_helper'

RSpec.describe Review, :type => :model do

  subject {
    Review.new(rating: 10,
            comment: "Kendrick Lamar")
  }

  it "is not valid" do
    expect(subject).to_not be_valid
  end

  it "is not valid without an rating" do
    subject.rating = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a comment" do
    subject.comment = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    it { should belong_to(:album) }
  end
end