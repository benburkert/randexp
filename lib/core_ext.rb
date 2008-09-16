%w[array integer range regexp].each do |filename|
  require File.join(File.dirname(__FILE__), 'core_ext', filename)
end
