module MarkovUuid
  class Chain < Hash
    SEPARATOR = "#-#-"
    attr_reader :words

    class << self
      def from_file(f)
        new(strip_punctuation File.read(f))
      end

      def strip_punctuation l
        l.gsub(/[[:punct:]]/," ").gsub!('  ', ' ').split " "
      end
    end

    def initialize words
      @words = words
    end

    def new_key(key, word)
      return SEPARATOR if word == "\n"

      word or key
    end

    def add
      key = SEPARATOR

      words.each do |word|
        (self[key] ||= []) << word

        key = new_key(key, word)
      end
    end

    def to_words length = 100
      key = keys.sample
      word = ""

      result = length.times.map do
        word = self[key].sample rescue nil
        key = new_key key, word
        word
      end.compact

      format result
    end

    def format words, i=32
      words.join("-")[0..i.to_i].gsub(/\A\w+-/,'').gsub(/-$/,"").gsub(/-\w+$/,"")
    end
  end
end
