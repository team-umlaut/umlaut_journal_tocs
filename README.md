# UmlautJournalTocs

Plug-in for [Umlaut](https://github.com/team-umlaut/umlaut) to provide Recent Articles for
a journal title via [JournalTOCs](http://www.journaltocs.hw.ac.uk/) API.

Depends on the [bento_search](https://github.com/jrochkind/bento_search) gem. 

## Installation

1. Add to Bemfile

    gem "umlaut_journal_tocs", "~> 1.0"

2. Register for JournalTOCs, with an email address. http://www.journaltocs.ac.uk/index.php?action=register

3. Add a `./config/initializer/umlaut_journal_tocs.rb` defining the bento_search engine
for JournalTocs, using your registered email address:

    # The engine name 'umlaut_journal_tocs' will be used by default
    # by the Umlaut service
    BentoSearch.register_engine("umlaut_journal_tocs") do |conf|
       conf.engine = "JournalTocsForJournal"
       conf.registered_email = "someone@example.org"
    end

(If you'd like to configure a service with a registered bento_search engine
with a different name, you can by passing in bento_search_engine key
in umlaut_services.yml configuration)

4. Set up the view rendering

5. Define your service in `./config/umlaut_services.yml`


## Development

### Running tests

We use VCR to record interactions with JournalTOCs in tests. To record
new cassettes, you need to have an ENV variable JOURNAL_TOCS_EMAIL
set to an email address registered for JournalTocs API. Your email
address will be kept out of recorded cassettes. 