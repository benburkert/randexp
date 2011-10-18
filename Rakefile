require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require "spec/rake/spectask"
require 'rake/rdoctask'

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

RUBYFORGE_USER = "benburkert"

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

Rake::GemPackageTask.new(spec) do |package|
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

##############################################################################
# Documentation
##############################################################################
task :doc => "doc:rerdoc"
namespace :doc do

  Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_files.add(RDOC_FILES)
    rdoc.main = 'README'
    rdoc.title = TITLE
    rdoc.rdoc_dir = "rdoc"
    rdoc.options << '--line-numbers' << '--inline-source'
  end

  desc "rdoc to rubyforge"
  task :rubyforge => :doc do
    sh %{chmod -R 755 rdoc}
    sh %{/usr/bin/scp -r -p rdoc/* #{RUBYFORGE_USER}@rubyforge.org:/var/www/gforge-projects/#{PROJECT_NAME}/#{GEM}}
  end
end

##############################################################################
# release
##############################################################################
task :release => [:specs, :package, :doc] do
  sh %{rubyforge add_release #{PROJECT_NAME} #{GEM} "#{GEM_VERSION}" pkg/#{GEM}-#{GEM_VERSION}.gem}
  %w[zip tgz].each do |ext|
    sh %{rubyforge add_file #{PROJECT_NAME} #{GEM} "#{GEM_VERSION}" pkg/#{GEM}-#{GEM_VERSION}.#{ext}}
  end
end
