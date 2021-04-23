# frozen_string_literal: true

feature 'Updating current bookmarks' do
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

  scenario 'a user updates a bookmark' do
    bookmarks = Bookmark.all
    first_bookmark, second_bookmark = bookmarks[0], bookmarks[1]

    visit('/bookmarks')
    expect(page).to have_link(first_bookmark.title)
    expect(page).to have_link(second_bookmark.title)

    first('.bookmark').click_link('Update')
    expect(page.current_path).to eq "/bookmarks/#{first_bookmark.id}/update"

    fill_in(:url, with: 'https://www.facebook.com')
    fill_in(:title, with: 'Facebook')
    click_button('Update')

    expect(page).not_to have_link(first_bookmark.title)
    expect(page).to have_link('Facebook')
    expect(page).to have_link(second_bookmark.title)
    expect(current_path).to eq('/bookmarks')
  end
end
