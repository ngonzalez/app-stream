source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.0.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "6.0.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# PostgreSQL
gem "pg"

# Use Redis adapter to run Action Cable in production
gem "redis"

# redis-rails
gem "redis-rails"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Environment
gem "dotenv-rails"

# Image assets processing
gem "dragonfly"

# GCP data store for dragonfly
gem "dragonfly-google_data_store"

# flexible and safe downloading of remote files
gem "down"

# draper
gem "draper"

# Track changes to your models, for auditing or versioning
gem "paper_trail"

# Paranoia is a re-implementation of acts_as_paranoid for Rails 4, 5, 6, and 7
gem "paranoia"

# Sidekiq
gem "sidekiq"

# taglib-ruby
gem "taglib-ruby"

# uuid
gem "uuid"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "pry"
end
