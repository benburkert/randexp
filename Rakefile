require 'rubygems/package_task'
require 'rubygems/specification'
require 'date'
require 'rspec/core/rake_task'

PROJECT_NAME = "randexp"
GEM = "randexp"
GEM_VERSION = "0.1.6"
AUTHOR = "Ben Burkert"
EMAIL = "ben@benburkert.com"
HOMEPAGE = "http://github.com/benburkert/randexp"
TITLE = "Randexp Gem"
SUMMARY = "Library for generating random strings."
FILES = %w(LICENSE README README Rakefile TODO CHANGELOG) + Dir.glob("{lib,spec}/**/*") + Dir.glob("wordlists/**/*")
RDOC_FILES = %w(LICENSE README README Rakefile TODO CHANGELOG) + Dir.glob("lib/**/*")

task :default => :specs

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = FILES
end

Gem::PackageTask.new(spec) do |package|
  package.gem_spec = spec
  package.need_zip = true
  package.need_tar = true
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

##############################################################################
# rSpec & rcov
##############################################################################
desc "Run all unit specs"
RSpec::Core::RakeTask.new("specs:unit") do |t|
  t.rspec_opts = ["--format", "documentation", "--colour"]
  t.pattern = "spec/unit/**/*_spec.rb"
  t.rcov_opts = %w[--sort coverage --sort-reverse]
  t.rcov_opts << '--only-uncovered'
  t.rcov_opts << '--output coverage/unit'

end

desc "Run all regression specs"
RSpec::Core::RakeTask.new("specs:regression") do |t|
  t.rspec_opts = ["--format", "documentation", "--colour"]
  t.pattern = "spec/regression/**/*_spec.rb"
  t.rcov_opts = %w[--sort coverage --sort-reverse]
  t.rcov_opts << '--only-uncovered'
  t.rcov_opts << '--output coverage/integration'
end

task :specs => ['specs:unit', 'specs:regression']
