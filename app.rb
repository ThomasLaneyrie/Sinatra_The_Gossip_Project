require 'bundler'
Bundler.require

require_relative 'lib/gossip'
# puts Gossip.find(1).content
Gossip.find_comments(1)