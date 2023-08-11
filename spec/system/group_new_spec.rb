require 'rails_helper'

RSpec.describe 'GroupIndex', type: :system do
  before(:each) do
    driven_by(:rack_test)
    @user = User.create!(role: 'user', profile_picture: 'avatar1.svg', name: 'John', email: 'testing@ruby.com',
                         password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email Address', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit user_group_index_path(@user.id)
  end

  it 'allows the user to create the first new group' do
    expect(page).to have_content('Add the first one')
  end

  it 'displays an empty cont if there are no groups present yet' do
    expect(page).to have_css('.group-empty-cont')
  end

  it 'shows multiple images on new group form' do
    visit new_user_group_path(@user.id)
    expect(page).to have_css('.picture-checkbox', count: 25)
  end

  it 'allows the user to create a new group' do
    visit new_user_group_path(@user.id)
    fill_in 'Group Name', with: 'Test Group'
    find(:css, '#group_icon_icon1_svg').set(true)
    click_button 'Create Group'
    expect(page).to have_content('Test Group')
  end

  it 'does not allow the user to create a group without a name' do
    visit new_user_group_path(@user.id)
    find(:css, '#group_icon_icon1_svg').set(true)
    click_button 'Create Group'
    expect(page).to have_content('Name can\'t be blank')
  end
end
