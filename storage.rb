#!/usr/bin/env ruby
#  Markov Chain Generator
# based on the Python version by Gary Burd: http://gary.burd.info/2003/11/markov-chain-generator.html
# Released into the public domain, please keep this notice intact
# (c) InVisible GmbH
# http://www.invisible.ch
#

require "YAML"

module KeySelector
  SEPARATOR = "#-#-"

  def new_key(key, word)
    return SEPARATOR if word == "\n"

    word or key
  end
end

require './words'


if __FILE__ == $0 then
  storage = Storage.new
  file = ARGV[0]

  storage.load "markov.yaml" unless file

  if file
    storage.add Markov.from_file file
    storage.save "markov.yaml"
  end

  require 'ruby-debug'

  puts storage.to_words
end
