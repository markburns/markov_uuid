module MarkovUuid
  class Chain < Hash
    SEPARATOR = "#-#-"
    attr_reader :words

    class << self
      def from_file f
        from_word_list(strip_punctuation File.read f)
      end

      def from_word_list words
        new.tap { |i| i.add words }
      end

      def strip_punctuation l
        l.gsub(/[[:punct:]]/," ").gsub!('  ', ' ').split " "
      end
    end

    def add words
      key = SEPARATOR

      words.each do |word|
        (self[key] ||= []) << word

        key = new_key(key, word)
      end
    end

    def new_key(key, word)
      return SEPARATOR if word == "\n"

      word or key
    end

    #note these are not by any means guaranteed to be unique
    #dependent on uuid length and corpus size
    #maybe maintain uniqueness elsewhere by regenerating unless unique
    def uuid length = 100
      key = keys.sample
      word = ""

      result = length.times.map do
        word = self[key].sample rescue nil
        key = new_key key, word
        word
      end.compact

      format result
    end

    def format result, i=32
      result.join("-")[0..i.to_i].
        gsub(/\A\w+-/ , "").
        gsub(/-$/     , "").
        gsub(/-\w+$/  , "")
    end
  end
end
