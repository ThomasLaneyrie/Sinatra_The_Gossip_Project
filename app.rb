require 'bundler'
Bundler.require

require_relative 'lib/gossip'
# puts Gossip.find(1).content
Gossip.update(1,"Jean-Jacques","Marie-Yvonne a couché avec Jean-Eudes")