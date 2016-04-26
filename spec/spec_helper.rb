require 'pry'
require 'coveralls'
Coveralls.wear!('rails')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    stub_const("Twilio::REST::Client", FakeSMS)
  end

  config.before :each, type: :feature do
    FakeSMS.messages = []
  end
end
