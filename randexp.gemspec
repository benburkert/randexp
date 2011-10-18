# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{randexp}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Burkert"]
  s.autorequire = %q{randexp}
  s.date = %q{2011-02-10}
  s.description = %q{Library for generating random strings.}
  s.email = %q{ben@benburkert.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "CHANGELOG", "lib/randexp", "lib/randexp/core_ext", "lib/randexp/core_ext/array.rb", "lib/randexp/core_ext/integer.rb", "lib/randexp/core_ext/range.rb", "lib/randexp/core_ext/regexp.rb", "lib/randexp/core_ext.rb", "lib/randexp/dictionary.rb", "lib/randexp/parser.rb", "lib/randexp/randgen.rb", "lib/randexp/reducer.rb", "lib/randexp/wordlists", "lib/randexp/wordlists/female_names.rb", "lib/randexp/wordlists/male_names.rb", "lib/randexp/wordlists/real_name.rb", "lib/randexp.rb", "spec/regression", "spec/regression/regexp_spec.rb", "spec/spec_helper.rb", "spec/unit", "spec/unit/core_ext", "spec/unit/core_ext/regexp_spec.rb", "spec/unit/randexp", "spec/unit/randexp/parser_spec.rb", "spec/unit/randexp/reducer_spec.rb", "spec/unit/randexp_spec.rb", "spec/unit/randgen_spec.rb", "wordlists/female_names", "wordlists/male_names", "wordlists/surnames"]
  s.homepage = %q{http://github.com/benburkert/randexp}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Library for generating random strings.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
