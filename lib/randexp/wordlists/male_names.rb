class RealName

  def self.load_male_first_names
    dir = File.dirname(__FILE__)
    if File.exists?("#{dir}/../../../wordlists/male_names")
      File.read("#{dir}/../../../wordlists/male_names").split
    else
      raise "words file not found"
    end
  end

  def self.male_first_names(options = {})
    if options.has_key?(:length)
      male_first_names_by_length[options[:length]]
    else
      @@male_first_names ||= load_male_first_names
    end
  end

  def self.male_first_names_by_length
    @@male_first_names_by_length ||= male_first_names.inject({}) {|h, w| (h[w.size] ||= []) << w; h }
  end
end
