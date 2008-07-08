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
  s.files       = ["Rakefile", "CHANGELOG", "LICENSE", "README", "lib/randexp.rb", "lib/randgen.rb", "lib/core_ext.rb", "dictionary.rb", "core_ext/array.rb", "core_ext/integer.rb", "core_ext/range.rb", "core_ext/regexp.rb", "randexp/parser.rb", "randexp/reducer.rb"]
  s.test_files  = ["spec/regression/regexp_spec.rb", "spec/unit/core_ext/regexp_spec.rb", "spec/unit/randexp/parser_spec.rb", "spec/unit/randexp/reducer.rb", "spec/unit/randexp_spec.rb", "spec/unit/randgen_spec.rb", "spec/spec_helper.rb"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["CHANGELOG", "README"]
  s.require_path = "lib"
end