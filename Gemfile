source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'

gem 'puma', '~> 3.7'
gem 'sqlite3'
gem 'turbolinks', '~> 5'

gem 'retriable', '~> 3.1'
gem 'listen', '~> 3.0'
gem 'twilio-ruby', '~> 5.10.3'
gem 'twitter-bootstrap-rails', '>= 4.0.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'coveralls', require: false
  gem 'rails-controller-testing', '>= 1.0.2'
  gem 'rspec-rails', '>= 3.6.1'
  gem 'shoulda-matchers', '~> 3.1'
end
