#encoding: utf-8
require File.expand_path('spec/spec_helper')
require './lib/markov_uuid'

describe MarkovUuid::Chain do
  let(:file) do
    <<-CONTENTS.gsub(/^\s*/, "")
      CHAPTER I. Down the Rabbit-Hole

      Alice was beginning to get very tired of sitting by her sister on the
      bank, and of having nothing to do: once or twice she had peeped into the
      book her sister was reading, but it had no pictures or conversations in
      it, 'and what is the use of a book,' thought Alice 'without pictures or
      conversation?'
    CONTENTS
  end


  specify do
    s = "これは Some text with, random -?! Punctuation in"
    MarkovUuid::Chain.strip_punctuation(s).should ==
      %w(これは Some text with random Punctuation in)
  end

  let(:words) do
    ["CHAPTER", "I", "Down", "the", "Rabbit", "Hole", "Alice", "was",
     "beginning", "to", "get", "very", "tired", "of", "sitting", "by", "her",
     "sister", "on", "the", "bank", "and", "of", "having", "nothing", "to",
     "do", "once", "or", "twice", "she", "had", "peeped", "into", "the",
     "book", "her", "sister", "was", "reading", "but", "it", "had", "no",
     "pictures", "or", "conversations", "in", "it", "and", "what", "is",
     "the", "use", "of", "a", "book", "thought", "Alice", "without",
     "pictures", "or", "conversation"]
  end

  specify do
    MarkovUuid::Chain.strip_punctuation(file).should == words
  end

  context 'from file' do
    before do
      File.stub(:read).and_return file
    end

    specify do
      chain = MarkovUuid::Chain.from_file ''
      #not sure how to test the randomness right now
      #so we can just check it's generating a list of words joined by '-'
      chain.uuid.should =~ /\A(\w+\-)+\w+\z/

      chain.uuid.split("-").each do |word|
        words.should include word
      end
    end
  end
end
