require 'rails_helper'

RSpec.describe 'GroupShow', type: :system do
  before(:each) do
    driven_by(:rack_test)
    @user = User.create!(role: 'user', profile_picture: 'avatar1.svg', name: 'John', email: 'testing@ruby.com',
                         password: 'password')
    @group = Group.create!(name: 'Test Group', icon: 'icon1.svg', user_id: @user.id)
    @movement1 = Movement.create!(name: 'Test Movement 1', amount: 5000, group_id: @group.id, user_id: @user.id)
    @movement2 = Movement.create!(name: 'Test Movement 2', amount: 5000, group_id: @group.id, user_id: @user.id)
    @movement3 = Movement.create!(name: 'Test Movement 3', amount: 5000, group_id: @group.id, user_id: @user.id)

    visit new_user_session_path

    fill_in 'Email Address', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit user_group_path(@user.id, @group.id)
  end

  it 'displays the movement names' do
    expect(page).to have_content('Test Movement 1')
    expect(page).to have_content('Test Movement 2')
    expect(page).to have_content('Test Movement 3')
  end

  it 'displays the total amount of all transactions' do
    expect(page).to have_content('Total: $15.000')
  end

  it 'displays the creation date of the movements' do
    expect(page).to have_css('.movement-date', count: 3)
  end

  it 'displays all deletion buttons' do
    expect(page).to have_css('.movement-delete', count: 3)
  end

  it 'displays all transactions' do
    expect(page).to have_css('.group-info', count: 3)
  end

  it 'displays each movement amount' do
    expect(page).to have_content('$5.000')
  end
end
