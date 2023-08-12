require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(role: 'user', profile_picture: 'picture.png', name: 'John', email: 'testing@ruby.com',
                         password: 'password')
  end

  it 'Validates' do
    expect(@user).to be_valid
  end

  it 'Haves the expected name' do
    expect(@user.name).to eq('John')
  end

  it 'Haves a profile picture' do
    expect(@user.profile_picture).to eq('picture.png')
  end
end
