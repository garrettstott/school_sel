require 'rails_helper'

feature 'Empty Schools', :js => true do 
  before(:each) do 
    visit root_path
  end

  scenario 'correct empty message' do 
    expect(page).to have_content('No Schools Found. You should make one.')
  end

  scenario 'create school link exists' do 
    expect(page).to have_content('Add School')
  end 
end

feature 'School Index page', :js => true do 
  before(:each) do 
    visit root_path
  end

  scenario 'Index page has schools logo' do 
    expect(page).to have_content('Schools')
  end

  scenario 'Index page has link to index page' do 
    expect(page).to have_link('Schools')
  end

  scenario 'Index page has link to add school' do 
    expect(page).to have_link('Add School')
  end


end

feature 'Create School', :js => true do
  before(:each) do 
    visit root_path
  end

  scenario 'click add school' do 
    expect(page).to have_content('Add School')
  end

  scenario 'add a new school' do
    click_link('Add School')
    fill_in('school_name', :with => 'JFK')
    fill_in('school_year_built', :with => '2002')
    find('input[type="submit"]').click
  end

  scenario 'redirects to show school path' do 
    click_link('Add School')
    fill_in('school_name', :with => 'JFK')
    fill_in('school_year_built', :with => '2002')
    find('input[type="submit"]').click 
    expect(page).to have_content('JFK')
    expect(current_path).to eq school_path(:id => '2')
  end
end

feature 'show school page', :js => true do 
  before(:each) do 
    visit root_path
    click_link('Add School')
    fill_in('school_name', :with => 'JFK')
    fill_in('school_phone_number', :with => '333-222-1111')
    fill_in('school_address', :with => '123 Fake Street')
    fill_in('school_email', :with => 'test@example.com')
    fill_in('school_year_built', :with => '1994')
    find('input[type="submit"]').click
  end

  scenario 'school show page has correct name' do 
    expect(page).to have_content('JFK')
  end

  scenario 'school show has correct info' do
    expect(page).to have_content('123 Fake Street')
    expect(page).to have_content('test@example.com')
    expect(page).to have_content('333-222-1111')
    expect(page).to have_content('1994')
  end

  scenario 'school show has edit button' do 
    expect(page).to have_content('Edit')
  end
end

feature 'Edit School', :js => true do 
  before(:each) do 
    visit root_path
    click_link('Add School')
    fill_in('school_name', :with => 'JFK')
    find('input[type="submit"]').click
  end

  scenario 'click edit link' do 
    click_link('Edit')
  end

  scenario 'edit user and save redirects to show path' do
    click_link('Edit')
    fill_in('school_year_built', :with => '1973')
    find('input[type="submit"]').click
    expect(current_path).to eq school_path(:id => '7')
  end

  scenario 'edit user and saves to database' do 
    click_link('Edit')
    fill_in('school_year_built', :with => '1973')
    find('input[type="submit"]').click
    expect(page).to have_content('1973')
  end

end

