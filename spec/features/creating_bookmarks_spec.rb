# frozen_string_literal: true

feature 'Adding a new bookmark' do
  scenario 'user submits a new bookmark entry' do
    visit('/bookmarks')
    click_link('New')
    expect(page.current_path).to eq ('/bookmarks/new')
    fill_in('url', with: 'http://zombo.com')
    fill_in('title', with: 'Zombo Time')
    click_button('Submit')

    expect(page).to have_link('Zombo Time')
    expect(page).to have_content 'Zombo Time'
  end
end
