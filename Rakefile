# -*- ruby -*-

require "rake"
require "rake/clean"
require "rake/gempackagetask"
require 'rake/rdoctask'
require "spec"
require "spec/rake/spectask"

DIR = File.dirname(__FILE__)
NAME = 'randexp'
SUMMARY =<<-EOS
Library for generating random strings.
EOS
GEM_VERSION = "0.1.0"

spec = Gem::Specification.new do |s|
  s.name = "randexp"
  s.version = "0.1.0"
  s.date = "2008-07-08"
  s.summary = "Library for generating random strings"
  s.email = "ben@benburkert.com"
  s.homepage = "http://github.com/benburkert/randexp"
  s.description = "randexp makes it easy to generate random string from most regular expressions."
  s.has_rdoc = true
  s.authors = ["Ben Burkert"]
  s.files       = ["Rakefile", "CHANGELOG", "LICENSE", "README", "lib/randexp.rb", "lib/randgen.rb", "lib/core_ext.rb", "lib/dictionary.rb", "lib/core_ext/array.rb", "lib/core_ext/integer.rb", "lib/core_ext/range.rb", "lib/core_ext/regexp.rb", "lib/randexp/parser.rb", "lib/randexp/reducer.rb"]
  s.test_files  = ["spec/regression/regexp_spec.rb", "spec/unit/core_ext/regexp_spec.rb", "spec/unit/randexp/parser_spec.rb", "spec/unit/randexp/reducer_spec.rb", "spec/unit/randexp_spec.rb", "spec/unit/randgen_spec.rb", "spec/spec_helper.rb"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["CHANGELOG", "README"]
  s.require_path = "lib"
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

##############################################################################
# rSpec & rcov
##############################################################################
desc "Run all unit specs"
Spec::Rake::SpecTask.new("specs:unit") do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir["spec/unit/**/*_spec.rb"].sort
  t.rcov = true
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--only-uncovered'
  t.rcov_opts << '--output coverage/unit'
  
end

desc "Run all regression specs"
Spec::Rake::SpecTask.new("specs:regression") do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir["spec/regression/**/*_spec.rb"].sort
  t.rcov = true
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--only-uncovered'
  t.rcov_opts << '--output coverage/integration'
end

task :specs => ['specs:unit', 'specs:regression']