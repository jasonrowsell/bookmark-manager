# frozen_string_literal: true

feature 'Adding a new bookmark' do
  scenario 'user submits a new bookmark entry' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://zombo.com')
    fill_in('title', with: 'Zombo Time')
    click_button('Submit')

    expect(page).to have_link('Zombo Time')
    expect(page).to have_content 'Zombo Time'
  end
end
