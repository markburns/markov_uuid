require File.expand_path('spec/spec_helper')

describe MarkovUuid::Storage do
  let(:file_klass) { mock 'File Class mock', read: file_contents }

  let(:file_contents) { "Down the rabbit hole" }

  before do
    MarkovUuid::Storage.any_instance.stub(:file_klass).and_return file_klass
  end

  context "empty cache file" do
    before do
      file_klass.stub(:open).and_yield ''
      YAML.stub(:dump).and_return true
    end

    specify do
      storage = MarkovUuid::Storage.new 'input_filename.txt', 'cache_filename.txt'

      storage.chain.should == {
        MarkovUuid::Chain::SEPARATOR => ["Down"],
        "Down"                       => ["the"],
        "rabbit"                     => ["hole"],
        "the"                        => ["rabbit"]
      }
    end

  end

  context "cached file" do
    before do
      yaml = <<-YAML.gsub(/^\s{6}/, "")
      ---
      a:
      - b
      - c
      YAML

      file_klass.stub(:open).and_yield yaml
    end

    specify do
      storage = MarkovUuid::Storage.new 'input_filename', 'cache_filename'
      storage.chain.should == {"a" => ["b", "c"]}
    end
  end
end
