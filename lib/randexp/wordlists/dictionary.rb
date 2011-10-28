class Randexp::Dictionary
  def self.load_dictionary
    dir = File.dirname(__FILE__)
    if File.exists?("#{dir}/../../../wordlists/words")
      File.read("#{dir}/../../../wordlists/words").split
    else
      raise "words file not found"
    end
  end

  def self.words(options = {})
    if options.has_key?(:length)
      words_by_length[options[:length]]
    else
      @@words ||= load_dictionary
    end
  end

  def self.words_by_length
    @@words_by_length ||= begin
      hash = Hash.new {|h,k| h[k] = [] }
      words.inject(hash) {|h, w| h[w.size] << w; h }
    end
  end
end
