source 'https://rubygems.org'
gem 'rails', '4.0.1'
gem 'pg'
gem 'jbuilder', '~> 1.2'
gem 'thin'
gem 'active_model_serializers'
gem 'bcrypt'
gem 'rails_12factor'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'faker'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-spork'
  gem 'rb-readline'
end

group :test, :development do
  gem 'spork'
  gem 'spork-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
end

group :test do
  gem 'nyan-cat-formatter'
end
