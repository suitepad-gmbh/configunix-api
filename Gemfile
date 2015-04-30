source 'https://rubygems.org'

# Core gems
gem 'rails',                        '~> 4.2.1'
gem 'rails-api',                    '~> 0.4.0'

# Database
gem 'pg',                           '~> 0.18.1'

# Authentication
gem 'doorkeeper',                   '~> 2.2.0'

# CORS
gem 'rack-cors',                    '~> 0.4.0'

# API Versioning
gem 'versionist',                   '~> 1.4.1'

# Better AR errors
gem 'rails_api_validation_errors',  '~> 1.0.1'

# Encryption
gem 'unix-crypt',                   '~> 1.3.0'

# Configuration management
gem 'figaro',                       '~> 1.1.0'

# Serialization
gem 'active_model_serializers',     '~> 0.9.3'

# Validators
gem 'ip_address_validator',         '~> 1.0.1'
gem 'validates_hostname',           '~> 1.0.5'

# AWS
gem 'fog',                          '~> 1.29.0'

###############################################
# Development dependencies
###############################################

group :development, :test do
  # Guard
  gem 'guard',                      '~> 2.12.5',  require: false
  gem 'guard-pow',                  '~> 2.0.0',   require: false
  gem 'guard-rspec',                '~> 4.5.0',   require: false
  gem 'guard-bundler',              '~> 2.1.0',   require: false

  # Pry console
  gem 'pry',                        '~> 0.10.1'
  gem 'pry-rails',                  '~> 0.3.4'
  gem 'pry-byebug',                 '~> 3.1.0'
  gem 'pry-stack_explorer',         '~> 0.4.9.2'
  gem 'pry-remote',                 '~> 0.1.8'

  # Console formatting
  gem 'awesome_print',              '~> 1.6.1'

  # RSpec testing instead of Test::Unit
  gem 'rspec-rails',                '~> 3.2.1'

  # Spring application pre-loader
  gem 'spring',                     '~> 1.3.4'
  gem 'spring-commands-rspec',      '~> 1.0.4'

  # Test factories and dummy data
  gem 'factory_girl_rails',         '~> 4.5.0'
  gem 'ffaker',                     '~> 2.0.0'
end

###############################################
# Test dependencies
###############################################

group :test do
  # Active Model Serializer testing
  gem 'shoulda-matchers',           '~> 2.8.0',   require: false
  gem 'rspec_active_model_serializers', '~> 0.1.1'

  # OS X notifications
  gem 'terminal-notifier-guard', '~> 1.6.4'

  # JSON testing
  gem 'json_spec',                  '~> 1.1.4'
end


###############################################
# Production dependencies
###############################################

group :production do
  # Server
  gem 'puma',                       '~> 2.11.2'
end
