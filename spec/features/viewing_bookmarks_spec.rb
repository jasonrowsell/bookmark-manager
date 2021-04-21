# frozen_string_literal: true

require 'pg'

feature 'Viewing bookmarks' do
  scenario 'when visiting index route' do
    Bookmark.create(
      url: 'https://www.window-swap.com',
      title: 'Window Swap'
    )
    Bookmark.create(
      url: 'https://www.isitchristmas.com',
      title: 'Is It Christmas'
    )
    Bookmark.create(
      url: 'https://www.zombo.com',
      title: 'Zombo Time'
    )

    visit('/bookmarks')

    expect(page).to have_link('Window Swap')
    expect(page).to have_link('Is It Christmas')
    expect(page).to have_link('Zombo Time')
  end
end
