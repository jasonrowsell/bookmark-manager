# frozen_string_literal: true

feature 'Deleting current bookmarks' do
  scenario 'a user deletes a bookmark' do
    Bookmark.create(
      url: 'https://www.window-swap.com',
      title: 'Window Swap'
    )
    visit('/bookmarks')

    expect(page).to have_link('Window Swap')

    first('.bookmark').click_button('Delete')

    expect(page).not_to have_link('Window Swap')
    expect(current_path).to eq('/bookmarks')
  end
end
