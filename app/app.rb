require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'

class BookmarkManager < Sinatra::Base
ENV['RACK_ENV'] ||= 'development'

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    title = params[:title]
    url = params[:url]
    tag = params[:tag]
    Link.create(url: url, title: title)
    Tag.create(name: tag)
    redirect to '/links'
  end

  run! if app_file == $0
end

DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
