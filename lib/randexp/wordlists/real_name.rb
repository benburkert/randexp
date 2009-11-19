class RealName
  def self.load_surnames
    dir = File.dirname(__FILE__)
    if File.exists?("#{dir}/../../../wordlists/surnames")
      File.read("#{dir}/../../../wordlists/surnames").split
    else
      raise "words file not found"
    end
  end

  def self.surnames(options = {})
    if options.has_key?(:length)
      surnames_by_length[options[:length]]
    else
      @@surnames ||= load_surnames
    end
  end

  def self.surnames_by_length
    @@surnames_by_length ||= surnames.inject({}) {|h, w| (h[w.size] ||= []) << w; h }
  end

  def self.first_names(options)
    case options[:gender].to_s
    when /^male/i
      male_first_names(options)
    when /^female/i
      female_first_names(options)
    else
      [male_first_names(options), female_first_names(options)].pick
    end
  end
end
