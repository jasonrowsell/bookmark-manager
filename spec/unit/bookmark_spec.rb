# frozen_string_literal: true

require 'bookmark'
require 'db_connection'

describe Bookmark do
  let(:subject) { described_class.new }

  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(
        url: 'http://www.window-swap.com',
        title: 'Window Swap'
      )
      Bookmark.create(
        url: 'http://www.isitchristmas.com',
        title: 'Is It Christmas'
      )
      Bookmark.create(
        url: 'http://www.zombo.com',
        title: 'Zombo Tim'
      )

      bookmarks = Bookmark.all

      expect(bookmarks.size).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.url).to eq 'http://www.window-swap.com'
      expect(bookmarks.first.title).to eq 'Window Swap'
    end
  end

  describe '.create' do
    context 'creating a new bookmark' do
      it 'creates a new bookmark url' do
        bookmark = Bookmark.create(
          url: 'http://www.zombo.com',
          title: 'Zombo Time'
        )
        expect(bookmark.url).to eq 'http://www.zombo.com'
      end
      it 'creates a new bookmark title' do
        bookmark = Bookmark.create(
          url: 'http://www.zombo.com',
          title: 'Zombo Time'
        )
        expect(bookmark.title).to eq 'Zombo Time'
      end
    end
  end

  describe '.delete' do
    it 'deletes selected bookmark' do
      bookmark = Bookmark.create(
        title: 'Zombo Time',
        url: 'http://www.zombo.com'
      )
  
      Bookmark.delete(id: bookmark.id)
  
      expect(Bookmark.all.size).to eq 0
    end
  end

  describe '.find_by' do
    context 'updating a new bookmark' do
      it 'returns a bookmark instance by id' do
        bookmark = Bookmark.create(
          url: 'http://www.zombo.com',
          title: 'Zombo Time'
        )
        bookmarks = Bookmark.all
        found_bookmark = Bookmark.find_by(id: bookmark.id)

        expect(found_bookmark.id).to eq bookmark.id
        expect(found_bookmark.title).to eq bookmark.title
        expect(found_bookmark.url).to eq bookmark.url
      end
    end
  end

  describe '#update' do
    it 'updates a selected bookmark' do
      bookmark = Bookmark.create(
        title: 'Zombo Time',
        url: 'http://www.zombo.com'
      )

      bookmarks = Bookmark.all
      first_bookmark = bookmarks[0]
  
      first_bookmark.update(url: 'http://www.facebook.com', title: 'Facebook')
      updated_bookmark = Bookmark.find_by(id: first_bookmark.id)

      expect(updated_bookmark.url).to eq 'http://www.facebook.com'
      expect(updated_bookmark.title).to eq 'Facebook'
    end
  end
end
