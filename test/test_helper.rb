require 'byebug'

require "#{File.dirname(__FILE__)}/support/vcr_filter.rb"
VCRFilter.sensitive_data! :journal_tocs_email

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

require 'minitest-spec-rails'

require 'umlaut'
require 'umlaut/test_help'
include Umlaut::TestHelp

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each do |f| 
  require f 
end



# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActiveSupport::TestCase.fixtures :all
end

if defined?(VCR)
  VCR.configure do |c|
    c.cassette_library_dir = 'test/vcr_cassettes'
    c.hook_into :webmock # or :fakeweb
  end
end

VCRFilter.sensitive_data! :journal_tocs_email

