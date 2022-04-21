# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'dotenv-rails'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'rake'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  # gem 'bullet' not db needed
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'formatador'
  gem 'pry'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  # gem 'factory_bot_rails' no db needed
  gem 'faker'
  gem 'rspec'
  gem 'timecop'
end
