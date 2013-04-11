$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'rspec'
require 'randexp'

Randexp::Dictionary.register(File.join(File.dirname(__FILE__), 'fixtures', 'osx_dictionary'))

RSpec::Runner.configure do |config|
end
