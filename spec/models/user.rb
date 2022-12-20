require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    User.new(email: "example@mail.ru",
            password: "password",)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "default user always admin" do
    expect(subject.role).to eq "user"
  end

  it "default user can't be admin" do
    expect(subject.admin?).to eq false
  end
end