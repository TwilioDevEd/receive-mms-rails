source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'

gem 'puma', '~> 3.7'
gem 'sqlite3'
gem 'turbolinks', '~> 5'

gem 'retriable', '~> 3.1'
gem 'listen', '~> 3.0'
gem 'twilio-ruby', '~> 5.30.0'
gem 'twitter-bootstrap-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'coveralls', require: false
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1'
end
