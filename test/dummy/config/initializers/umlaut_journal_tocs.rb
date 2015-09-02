    # The engine name 'umlaut_journal_tocs' will be used by default
    # by the Umlaut service
    BentoSearch.register_engine("umlaut_journal_tocs") do |conf|
       conf.engine = "JournalTocsForJournal"
       conf.registered_email = defined?(VCRFilter) ? VCRFilter[:journal_tocs_email] : ENV["JOURNAL_TOCS_EMAIL"]
    end


    # One we use in testing to test a bad email
    BentoSearch.register_engine("bad_email_journal_tocs") do |conf|
       conf.engine = "JournalTocsForJournal"
       conf.registered_email = "nobody@nowhere.com"
    end