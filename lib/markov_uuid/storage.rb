require "yaml"
require "fileutils"
module MarkovUuid
  class Storage
    attr_accessor :data, :cache_file, :input_file

    #note these are not by any means guaranteed to be unique
    #dependent on uuid length and corpus size
    #maybe maintain uniqueness elsewhere by regenerating unless unique
    def uuid
      chain.uuid
    end

    def chain
      @chain ||= MarkovUuid::Chain.new data
    end

    def initialize cache_file, input_file
      @cache_file, @input_file = cache_file, input_file

      preload_data
    end

    def save
      File.open(cache_file, "w"){|f| YAML.dump(@data, f) }
    end

    def open
      FileUtils.touch cache_file
      File.open(cache_file) do |f|
        @data = YAML.load f
      end

      @data
    end

    private

    def data
      @data ||= MarkovUuid::Chain.from_file input_file
    end

    def preload_data
      unless open
        data
        save
      end
    end
  end
end
