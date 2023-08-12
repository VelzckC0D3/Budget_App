require 'rails_helper'

RSpec.describe 'MovementNew', type: :system do
  before(:each) do
    driven_by(:rack_test)
    @user = User.create!(role: 'user', profile_picture: 'avatar1.svg', name: 'John', email: 'testing@ruby.com',
                         password: 'password')
    @group = Group.create!(name: 'Test Group', icon: 'icon1.svg', user_id: @user.id)

    visit new_user_session_path

    fill_in 'Email Address', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit new_user_group_movement_path(@user.id, @group.id)
  end

  it 'allows the user to create a new movement' do
    fill_in 'Transaction Name', with: 'Test Movement'
    fill_in 'Amount', with: 5000
    click_button 'Create Movement'
    expect(page).to have_content('Test Movement')
  end

  it 'shows the total amount of a new movement' do
    fill_in 'Transaction Name', with: 'Test Movement'
    fill_in 'Amount', with: 5000
    click_button 'Create Movement'
    expect(page).to have_content('Total: $5.000')
  end

  it 'shows the movement name after creating a group' do
    fill_in 'Transaction Name', with: 'Test Movement'
    fill_in 'Amount', with: 5000
    click_button 'Create Movement'
    expect(page).to have_content('Test Movement')
  end

  it 'updates the total amount after creating a new movement' do
    fill_in 'Transaction Name', with: 'Test Movement'
    fill_in 'Amount', with: 5000
    click_button 'Create Movement'
    visit new_user_group_movement_path(@user.id, @group.id)
    fill_in 'Transaction Name', with: 'Second Test Movement'
    fill_in 'Amount', with: 7500
    click_button 'Create Movement'
    expect(page).to have_content('Total: $12.500')
  end

  it 'display all the movements for a group' do
    fill_in 'Transaction Name', with: 'Test Movement'
    fill_in 'Amount', with: 5000
    click_button 'Create Movement'
    visit new_user_group_movement_path(@user.id, @group.id)
    fill_in 'Transaction Name', with: 'Second Test Movement'
    fill_in 'Amount', with: 7500
    click_button 'Create Movement'
    visit new_user_group_movement_path(@user.id, @group.id)
    fill_in 'Transaction Name', with: 'Third Test Movement'
    fill_in 'Amount', with: 10_000
    click_button 'Create Movement'
    expect(page).to have_css('.group-info', count: 3)
  end
end
