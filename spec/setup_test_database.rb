# frozen_string_literal: true

require 'pg'

def setup_test_database
  begin
    connection = PG.connect(dbname: "bookmark_manager_#{ENV['RACK_ENV']}")
    connection.exec('TRUNCATE TABLE bookmarks;')
  rescue PG::Error => e
    puts e.message
  ensure
    connection.close if connection
  end
end
