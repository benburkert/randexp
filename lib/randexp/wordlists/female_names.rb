class RealName

  def self.load_female_first_names
    dir = File.dirname(__FILE__)
    if File.exists?("#{dir}/../../../wordlists/female_names")
      File.read("#{dir}/../../../wordlists/female_names").split
    else
      raise "words file not found"
    end
  end

  def self.female_first_names(options = {})
    if options.has_key?(:length)
      female_first_names_by_length[options[:length]]
    else
      @@female_first_names ||= load_female_first_names
    end
  end

  def self.female_first_names_by_length
    @@female_first_names_by_length ||= female_first_names.inject({}) {|h, w| (h[w.size] ||= []) << w; h }
  end
end
