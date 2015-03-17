require "capybara/rspec"
require "rails_helper"

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.color = true

  config.include Rails.application.routes.url_helpers
  config.tty = true
end
