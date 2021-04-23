# frozen_string_literal: true

require 'pg'

# Bookmark model interacting with DB
class Bookmark
  def self.all
    begin
      connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
      result = connection.exec('SELECT * FROM bookmarks')
      result.map do |bookmark|
          new(
          id: bookmark['id'],
          title: bookmark['title'],
          url: bookmark['url']
        )
      end
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.create(url:, title:)
    begin
      connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
      result = connection.exec(
        "INSERT INTO bookmarks (url, title)
        VALUES('#{url}', '#{title}')
        RETURNING id, title, url"
      )
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end

      new(
      id: result[0]['id'],
      title: result[0]['title'],
      url: result[0]['url']
    )
  end

  def self.delete(id:)
    begin
      connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
      connection.exec("DELETE FROM bookmarks WHERE id=#{id}")
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  def self.find_by(id:)
    begin
      connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
      result = connection.exec("SELECT * FROM bookmarks WHERE id=#{id}")
      result.map do |bookmark|
          new(
          id: bookmark['id'],
          title: bookmark['title'],
          url: bookmark['url']
        )
      end.first
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id    = id
    @title = title
    @url   = url
  end

  def update(url:, title:)
    begin
      connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
      connection.exec(
        "UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id=#{id}")
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
  end
end
