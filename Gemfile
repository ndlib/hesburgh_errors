source "https://rubygems.org"

# Declare your gem's dependencies in hesburgh_api.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
gem 'therubyracer'


group :development, :test do
  gem "hesburgh_infrastructure", git: 'git@git.library.nd.edu:hesburgh_infrastructure'
  gem "mysql2"
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-spork'
  gem 'growl'
  gem 'rb-readline'

  gem 'devise'
  gem 'devise_cas_authenticatable'
end

