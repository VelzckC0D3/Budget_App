require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(name: 'John', email: 'testing@ruby.com', password: 'password', confirmed_at: Time.now)
  end

  it 'Validates' do
    expect(@user).to be_valid
  end

  it 'Haves the expected name' do
    expect(@user.name).to eq('John')
  end
end
