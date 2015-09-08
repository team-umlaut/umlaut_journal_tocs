# UmlautJournalTocs

[![Gem Version](https://badge.fury.io/rb/umlaut_journal_tocs.svg)](http://badge.fury.io/rb/umlaut_journal_tocs)  [![Build Status](https://travis-ci.org/team-umlaut/umlaut_journal_tocs.svg)](https://travis-ci.org/team-umlaut/umlaut_journal_tocs)

Plug-in for [Umlaut](https://github.com/team-umlaut/umlaut) to provide Recent Articles for
a journal title via [JournalTOCs](http://www.journaltocs.hw.ac.uk/) API.

Depends on the [bento_search](https://github.com/jrochkind/bento_search) gem. 

## Installation

1. Add to Gemfile

    gem "umlaut_journal_tocs", "~> 1.0"

2. Register for JournalTOCs, with an email address. http://www.journaltocs.ac.uk/index.php?action=register

3. Add a `./config/initializer/umlaut_journal_tocs.rb` defining the bento_search engine
for JournalTocs, using your registered email address:

    # The engine name 'umlaut_journal_tocs' will be used by default
    # by the Umlaut service
    BentoSearch.register_engine("umlaut_journal_tocs") do |conf|
      conf.engine = "JournalTocsForJournal"
      conf.registered_email = "registered_email@example.com"
      conf.for_display do |display|
        display.decorator = 'UmlautJournalTocsDecorator'
        display.item_partial = "umlaut_journal_tocs/bento_item"
      end
    end


4. Add view section to page for recent articles

In your local `./app/controllers/umlaut_controller.rb`, in the `umlaut_config.configure` do section, add:

    resolve_sections.insert_section UmlautJournalTocs.resolve_section_definition

5. Define your service in `./config/umlaut_services.yml`

      JournalTocs:
        type: JournalTocsAdapter
        priority: c



## Development

### Running tests

We use VCR to record interactions with JournalTOCs in tests. To record
new cassettes, you need to have an ENV variable JOURNAL_TOCS_EMAIL
set to an email address registered for JournalTocs API. Your email
address will be kept out of recorded cassettes. 