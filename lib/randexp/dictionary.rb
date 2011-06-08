class Randexp::Dictionary
  def self.load_dictionary
    if File.exists?("/usr/share/dict/words")
      File.read("/usr/share/dict/words").split
    elsif File.exists?("/usr/dict/words")
      File.read("/usr/dict/words").split
    else
      raise "Words file not found. Check if it is installed in (/usr/share/dict/words or /usr/dict/words) "
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
