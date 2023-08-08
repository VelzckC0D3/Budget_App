require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create!(name: 'John', email: 'testing@ruby.com', password: 'password', confirmed_at: Time.now)
    @group = Group.create!(name: 'Test Group', icon: 'icon.svg', user_id: @user.id)
  end

  it 'The user_id is equals to the user id' do
    expect(@group.user_id).to eq(@user.id)
  end
end
