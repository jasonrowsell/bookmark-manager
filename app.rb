# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

ENV['RACK_ENV'] ||= 'development'

# Organizes and manages URL bookmarks
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  get '/bookmarks/:id/update' do
    @bookmark = Bookmark.find_by(id: params[:id])
    erb :'bookmarks/update'
  end

  post '/bookmarks' do
    Bookmark.update(url: params[:url], title: params[:title])
    redirect 'bookmarks'
  end

  post '/bookmarks/create' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  put '/bookmarks' do
    bookmark = Bookmark.find_by(id: params[:id])
    bookmark.update(url: params[:url], title: params[:title])
    redirect 'bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
