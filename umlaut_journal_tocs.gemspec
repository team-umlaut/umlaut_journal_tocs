$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "umlaut_journal_tocs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "umlaut_journal_tocs"
  s.version     = UmlautJournalTocs::VERSION
  s.authors     = ["Jonathan Rochkind"]
  s.email       = ["jonathan@dnil.net"]
  s.homepage    = "https://github.com/team-umlaut/umlaut_journal_tocs"
  s.summary     = "Umlaut plugin for Recent Articles display from JournalTocs"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.test_files = Dir["test/**/*"] - Dir["test/dummy/log/**/*"] - Dir["test/dummy/tmp/**/*"] - Dir["test/db/*.sqlite"] - Dir["test/dummy/db/**/*.sqlite3"]

  s.add_dependency "bento_search", "~> 1.4", ">= 1.4.2"
  s.add_dependency "umlaut", "~> 4.1"


  s.add_development_dependency "sqlite3"
end
