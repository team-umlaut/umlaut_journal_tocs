$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "umlaut_journal_tocs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "umlaut_journal_tocs"
  s.version     = UmlautJournalTocs::VERSION
  s.authors     = ["Jonathan Rochkind"]
  s.email       = ["jonathan@dnil.net"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of UmlautJournalTocs."
  s.description = "TODO: Description of UmlautJournalTocs."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "bento_search", "~> 1.4"
  s.add_dependency "umlaut", "~> 4.1"


  s.add_development_dependency "sqlite3"

  s.add_development_dependency "minitest-spec-rails"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr", "~> 2.9"
end
