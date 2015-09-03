require 'bento_search'

class JournalTocsAdapter < Service
  include MetadataHelper

  def initialize(config)
    @bento_search_engine = 'umlaut_journal_tocs'
    @max_items = 40
    super(config)
  end


  def service_types_generated
    return [ServiceTypeValue[:journal_tocs_bento]]
  end

  def handle(request)
    issn = get_issn(request.referent)

    # we can do nothing without ISSN
    unless issn
      return request.dispatched(self, true)
    end

    searcher = BentoSearch.get_engine(@bento_search_engine)

    bento_results = searcher.fetch_by_issn(issn)

    bento_results.slice!(@max_items, bento_results.length)

    # We store JSON serialization of results in the display_text field
    # of a single ServiceResponse, hacky but okay. 
    if bento_results.length > 0
      request.add_service_response( 
        :service=>self, 
        :display_text => bento_results.dump_to_json,
        :service_type_value => :journal_tocs_bento
      )
    end

    return request.dispatched(self, true)
  rescue BentoSearch::FetchError => e
    Rails.logger.error("JournalTocsAdapter: Could not fetch results: #{e}")
    return request.dispatched(self, false, e)
  end

end