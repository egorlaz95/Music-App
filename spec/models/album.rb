require 'rails_helper'

RSpec.describe Album, :type => :model do

  subject {
    Album.new(title: "DAMN",
            artist: "Kendrick Lamar")
  }

  it "is not valid without singer" do
    expect(subject).to_not be_valid
  end

  it "is not valid without an title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a artist" do
    subject.artist = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    it { should belong_to(:singer) }
    it { should have_many(:reviews) }
  end

end