Gem::Specification.new do |s|
  s.name = %q{randexp}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Burkert"]
  s.autorequire = %q{randexp}
  s.date = %q{2008-07-18}
  s.description = %q{Library for generating random strings.}
  s.email = %q{ben@benburkert.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "CHANGELOG", "lib/core_ext", "lib/core_ext/array.rb", "lib/core_ext/integer.rb", "lib/core_ext/range.rb", "lib/core_ext/regexp.rb", "lib/core_ext.rb", "lib/dictionary.rb", "lib/randexp", "lib/randexp/parser.rb", "lib/randexp/reducer.rb", "lib/randexp.rb", "lib/randgen.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/benburkert/randexp}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Library for generating random strings.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
