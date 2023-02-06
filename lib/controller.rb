require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params['id'].to_i), comments: Gossip.find_comments(params['id'].to_i)}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.find(params['id'].to_i)}
  end

  post '/gossips/:id/edit/' do
    puts "salut"
    Gossip.update(params['id'].to_i, params["gossip_author"], params["gossip_content"])
    redirect "/"
  end

  get '/gossips/:id/comments/' do
    erb :comments, locals: {gossip: Gossip.find(params['id'].to_i)}
  end

  post '/gossips/:id/comments/' do
    Gossip.add_comments(params['id'].to_i, params["gossip_comment"])
    redirect "/"
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end  
end