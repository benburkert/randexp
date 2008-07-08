# -*- ruby -*-

require "rake"
require "rake/clean"
require "rake/gempackagetask"
require 'rake/rdoctask'
require "spec"
require "spec/rake/spectask"

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