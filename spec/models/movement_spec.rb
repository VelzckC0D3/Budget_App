require 'rails_helper'

RSpec.describe Movement, type: :model do
  before(:each) do
    @user = User.create!(role: 'user', profile_picture: 'picture.png', name: 'John', email: 'testing@ruby.com',
                         password: 'password')
    @group1 = Group.create!(name: 'Test Group', icon: 'icon.svg', user_id: @user.id)
    @group2 = Group.create!(name: 'Test Group', icon: 'icon.svg', user_id: @user.id)
    @movement1 = Movement.create!(name: 'Test Movement', group_id: @group1.id, user_id: @user.id, amount: 500)
    @movement2 = Movement.create!(name: 'Test Movement', group_id: @group1.id, user_id: @user.id, amount: 500)
    @movement3 = Movement.create!(name: 'Test Movement', group_id: @group2.id, user_id: @user.id, amount: 500)
  end

  it 'Belongs to the same user as the group user id' do
    expect(@movement1.user_id).to eq(@user.id && @group1.user_id)
  end

  it 'The total amount through movements of Group is correct' do
    expect(@group1.movements.sum(:amount)).to eq(1000)
  end

  it 'The total amount through movements of User is correct' do
    expect(@user.movements.sum(:amount)).to eq(1500)
  end
end
