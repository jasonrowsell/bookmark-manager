# frozen_string_literal: true

require 'pg'
require 'db_connection'

# Bookmark model interacting with DB
class Bookmark
  include DBConnection

  def self.all
    result = DBConnection.exec('SELECT * FROM bookmarks')
    result.map do |bookmark|
        new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.create(url:, title:)
    result = DBConnection.exec(
      "INSERT INTO bookmarks (url, title)
      VALUES('#{url}', '#{title}')
      RETURNING id, title, url"
    )
    new(
    id: result[0]['id'],
    title: result[0]['title'],
    url: result[0]['url']
    )
  end

  def self.delete(id:)
    DBConnection.exec("DELETE FROM bookmarks WHERE id=#{id}")
  end

  def self.find_by(id:)
    result = DBConnection.exec("SELECT * FROM bookmarks WHERE id=#{id}")
    result.map do |bookmark|
        new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end.first
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id    = id
    @title = title
    @url   = url
  end

  def update(url:, title:)
    DBConnection.exec(
      "UPDATE bookmarks SET url = '#{url}', title = '#{title}'
      WHERE id=#{id}"
    )
  end
end
