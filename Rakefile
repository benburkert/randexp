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
  s.name         = NAME
  s.summary      = SUMMARY

  s.version      = GEM_VERSION
  s.platform     = Gem::Platform::RUBY
  
  s.has_rdoc         = true

  s.require_path = "lib"
  s.files        = %w(Rakefile) + Dir["lib/**/*"]
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
  package.need_zip = true
  package.need_tar = true
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

desc "Run all integration specs"
Spec::Rake::SpecTask.new("specs:integration") do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir["spec/integration/**/*_spec.rb"].sort
  t.rcov = true
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--only-uncovered'
  t.rcov_opts << '--output coverage/integration'
end

task :specs => ['specs:unit', 'specs:integration']