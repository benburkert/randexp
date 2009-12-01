bin_path "gbin"
disable_system_gems

only :release do
  gem 'ParseTree',           :require_as => [ ]
end

only :test do
  gem 'rspec',               :require_as => 'spec'
  gem 'rake'
  gem 'bundler'
  gem 'ruby-debug'
  gem 'rcov'
end
