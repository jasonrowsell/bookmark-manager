# frozen_string_literal: true

require 'pg'

# Bookmark model interacting with DB
class Bookmark
  def self.all
    db = if ENV['RACK_ENV'] == 'test'
           'bookmark_manager_test'
         else
           'bookmark_manager'
         end

    connection = PG.connect(dbname: db)

    result = connection.exec('SELECT * FROM bookmarks')
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.create(url:, title:)
    db = if ENV['RACK_ENV'] == 'test'
           'bookmark_manager_test'
         else
           'bookmark_manager'
         end

    connection = PG.connect(dbname: db)

    result = connection.exec(
      "INSERT INTO bookmarks (url, title)
      VALUES('#{url}', '#{title}')
      RETURNING id, title, url"
    )

    Bookmark.new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id    = id
    @title = title
    @url   = url
  end
end
