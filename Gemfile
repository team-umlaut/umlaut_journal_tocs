source 'https://rubygems.org'

# Declare your gem's dependencies in umlaut_journal_tocs.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# Gems that would normally be in application Gemfile
gem 'jquery-rails'

# To use a debugger
gem 'byebug', group: [:development, :test]

#gem 'bento_search', :path => "../bento_search"

#gem 'umlaut', :path => "../umlaut"

# These don't work well in the gemspec, they seem to wind up loaded in
# non-test environments.
group "test" do
  gem "minitest-spec-rails"
  gem "vcr", "~> 2.9"
  gem "webmock", "~> 1.11"
end
