require 'rails_helper'

RSpec.describe "GroupIndices", type: :system do
  before(:each) do
    driven_by(:rack_test)
    @user = User.create!(role: 'user', profile_picture: 'avatar1.svg', name: 'John', email: 'testing@ruby.com', password: 'password', confirmed_at: Time.now)
    @group = Group.create!(name: 'Test Group', icon: 'icon1.svg', user_id: @user.id)


    visit new_user_session_path

    fill_in 'Email Address', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit user_group_index_path(@user.id)
  end

  it 'displays the group name' do
    expect(page).to have_css(".group-name")
  end
  
  it 'displays the group icon' do
    expect(page).to have_css(".group-image")
  end
  
  it 'displays the name of the group' do
    expect(page).to have_content('Test Group')
  end

  it 'displays the creation date of the group' do
    expect(page).to have_css('.group-created')
  end
  
  it 'displays the total amount of the transactions' do
    expect(page).to have_css('.group-movement-total')
  end
end
