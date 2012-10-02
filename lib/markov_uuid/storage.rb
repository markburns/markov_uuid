require "yaml"
require "fileutils"
module MarkovUuid
  class Storage
    def initialize filename
      @filename = filename
    end

    attr_accessor :data, :filename

    def save
      File.open(filename, "w"){|f| YAML.dump(@data, f) }
    end

    def load
      FileUtils.touch filename
      File.open(filename) do |f|
        @data = YAML.load f
      end
    end
  end
end
