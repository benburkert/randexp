Gem::Specification.new do |s|
  s.name = "randexp"
  s.version = "0.1.0"
  s.date = "2008-07-08"
  s.summary = "Library for generating random strings"
  s.email = "ben@benburkert.com"
  s.homepage = "http://github.com/benburkert/randexp"
  s.description = "randexp makes it easy to generate random string from most regular expressions."
  s.has_rdoc = true
  s.authors = ["Ben Burkert"]
  s.files       = %w(Rakefile CHANGELOG LICENSE README) + Dir["lib/**/*"]
  s.test_files  = Dir["spec/**/*"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["CHANGELOG", "README"]
  s.require_path = "lib"
end