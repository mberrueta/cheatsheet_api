# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.2', '>= 7.0.2.3'

gem 'sqlite3', '~> 1.4'

gem 'puma', '~> 5.0'

gem 'rake'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # gem 'bullet' not db needed
  gem 'brakeman'# This workflow uses actions that are not certified by GitHub.  They are
  # provided by a third-party and are governed by separate terms of service,
  # privacy policy, and support documentation.
  #
  # This workflow will install a prebuilt Ruby version, install dependencies, and
  # run tests and linters.
  name: "Ruby on Rails CI"
  on:
    push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  jobs:
    test:
    runs-on: ubuntu-latest
  env:
    RAILS_ENV: test
  steps:
    - name: Checkout code
  uses: actions/checkout@v3
  # Add or replace dependency steps here
  - name: Install Ruby and gems
  uses: ruby/setup-ruby@8f312efe1262fb463d906e9bf040319394c18d3e # v1.92
  with:
    ruby-version: '3.1'
  bundler-cache: true
  # Add or replace database setup steps here
  # Add or replace test runners here
  - name: Run tests
  run: bin/rake

  lint:
    runs-on: ubuntu-latest
  steps:
    - name: Checkout code
  uses: actions/checkout@v3
  - name: Install Ruby and gems
  uses: ruby/setup-ruby@8f312efe1262fb463d906e9bf040319394c18d3e # v1.92
  with:
    bundler-cache: true
  # Add or replace any other lints here
  - name: Security audit dependencies
  run: bin/bundler-audit --update
  - name: Security audit application code
  run: bin/brakeman -q -w2
  - name: Lint Ruby files
  run: bin/rubocop --parallel
  - name: Best Practices
  run: bin/rails_best_practices

  gem 'bundler-audit'
  gem 'dotenv'
  gem 'formatador'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  # gem 'factory_bot_rails' no db needed
  gem 'faker'
  gem 'rspec'
  gem 'timecop'
end
