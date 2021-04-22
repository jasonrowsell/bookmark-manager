# frozen_string_literal: true

feature 'Deleting current bookmarks' do
  before {
    Bookmark.create(
      url: 'https://www.window-swap.com',
      title: 'Window Swap'
    )
  }
  before {
    Bookmark.create(
      url: 'https://www.zombo.com',
      title: 'Zombo Time'
    )
  }

  scenario 'a user deletes a bookmark' do
    bookmarks = Bookmark.all
    first_bookmark, second_bookmark = bookmarks[0], bookmarks[1]
    visit('/bookmarks')

    expect(page).to have_link(first_bookmark.title)
    expect(page).to have_link(second_bookmark.title)

    first('.bookmark').click_button('Delete')
    expect(page).not_to have_link(first_bookmark.title)
    expect(page).to have_link(second_bookmark.title)
    expect(current_path).to eq('/bookmarks')
  end
end
