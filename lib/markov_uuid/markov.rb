module MarkovUuid
  class Markov
    include KeySelector
    SEPARATOR = "#-#-"

    def to_s i=32
      @words.join("-")[0..i.to_i].gsub(/\A\w+-/,'').gsub(/-$/,"").gsub(/-\w+$/,"")
    end

    def initialize words
      @words = words
    end

    def add_to markov_data
      key = SEPARATOR

      @words.each do |word|
        (markov_data[key] ||= []) << word

        key = new_key(key, word)
      end
    end

    private

    class << self
      def from_file( f )
        new lines(f).map { |l| from_string l }.flatten
      end

      private

      def from_string l
        l.gsub(/[^a-z ]/i,'').split " "
      end

      def lines f
        content = File.read f
        c = content.length
        r = rand c
        content[r-c .. r+c].gsub(/\A\s\w+/,"").gsub(/\w+\s\z/,"").downcase.split "\n"
      end
    end
  end
end
