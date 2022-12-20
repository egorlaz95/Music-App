require 'rails_helper'

RSpec.describe Singer, :type => :model do

  subject {
    Singer.new(name: "Kendrick Lamar")
  }

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
 
  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:albums) }
  end
end