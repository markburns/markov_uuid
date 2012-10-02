require "yaml"
require "fileutils"
module MarkovUuid
  class Storage
    include KeySelector
    attr_accessor :data

    def initialize(data = nil )
      @data = data if data.class == Hash
      @data ||= Hash.new
    end

    def add words
      words.add_to @data
    end

    def to_words length = 100
      key = Markov::SEPARATOR
      word = ""

      result = length.times.map do
        word = @data[key].sample rescue nil
        key = new_key key, word
        word
      end.compact

      Markov.new result
    end

    def save filename
      File.open(filename, "w"){|f| YAML.dump(@data, f) }
    end

    def load filename
      FileUtils.touch filename
      File.open(filename) do |f|
        @data = YAML.load f
      end
    end
  end
end
