source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                   '~> 5.1.1'
gem 'sqlite3'
gem 'puma',                    '~> 3.7'
gem 'simple_form',             '~> 3.5'

gem 'carrierwave',             '~> 1.0'
gem 'mini_magick',             '~> 4.8'

gem 'sass-rails',              '~> 5.0'
gem 'uglifier',                '>= 1.3.0'
gem 'slim-rails',              '~> 3.1'
gem 'semantic-ui-sass',        '~> 2.2'
gem 'coffee-rails',            '~> 4.2'
gem 'turbolinks',              '~> 5'
gem 'jquery-rails',            '~> 4.3',   '>= 4.3.1'

group :development do
  gem 'web-console',           '>= 3.3.0'
  gem 'listen',                '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'rspec'
  gem 'rubocop'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'capybara',              '~> 2.13'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'launchy',               '~> 2.4',  '>= 2.4.3'
  gem 'selenium-webdriver',    '~> 3.4',  '>= 3.4.4'
  gem 'database_cleaner',      '~> 1.5',  '>= 1.5.3'
end
