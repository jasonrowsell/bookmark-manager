# frozen_string_literal: true

require 'pg'
require 'db_connection'

def setup_test_database
  DBConnection.exec('TRUNCATE TABLE bookmarks;')
end
