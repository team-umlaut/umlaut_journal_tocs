require 'test_helper'

class JournalTocsAdapterTest < ActiveSupport::TestCase
  extend TestWithCassette

  before do    
    @service_config = {
      "type" => "JournalTocsAdapter",
      "priority" => 1
    }
    @service_config_list = {'default' => {
      "services" => {
          "journal_tocs" => @service_config
        }
      }
    }

    @service = JournalTocsAdapter.new(@service_config.merge("service_id" => "journal_tocs"))
  end
  
  describe "with no ISSN" do
    test "does nothing" do 
      umlaut_request = fake_umlaut_request("/resolve?au=Journal+Of+Something&genre=journal")

      @service.handle(umlaut_request)

      assert_dispatched umlaut_request, "journal_tocs"
      assert_service_responses umlaut_request, 'journal_tocs', :number => 0
    end
  end

  describe "article-level citation" do
    test "does nothing" do
      @umlaut_request = fake_umlaut_request("/resolve?au=JAMA&genre=article&issn=1538-3598&volume=1&issue=1&spage=1")
      @service.handle(@umlaut_request)

      assert_dispatched @umlaut_request, "journal_tocs"
      response = assert_service_responses @umlaut_request, 'journal_tocs', :number => 0
    end
  end

  describe "with ISSN that works" do
    before do
      @umlaut_request = fake_umlaut_request("/resolve?au=JAMA&genre=journal&issn=1538-3598")
    end

    test_with_cassette "generates response" do
      @service.handle(@umlaut_request)

      assert_dispatched @umlaut_request, "journal_tocs"
      response = assert_service_responses @umlaut_request, 'journal_tocs', :number => 1

      # Can we de-serialize?
      bento_results = BentoSearch::Results.load_json(response.display_text)

      assert_kind_of BentoSearch::Results, bento_results
      assert bento_results.count > 0
      bento_results.each do |result|
        assert_kind_of BentoSearch::ResultItem, result
      end
    end
  end

  describe "with ISSN with no JournalTocs results" do
    before do
      @umlaut_request = fake_umlaut_request("/resolve?au=JAMA&genre=journal&issn=12345678")
    end

    test_with_cassette("generates no response") do
      @service.handle(@umlaut_request)

      assert_dispatched @umlaut_request, "journal_tocs"
      assert_service_responses @umlaut_request, 'journal_tocs', :number => 0
    end
  end

  describe "with bad email" do
    before do
      config = @service_config.merge("service_id" => "journal_tocs", 
        "bento_search_engine" => "bad_email_journal_tocs")
      @service = JournalTocsAdapter.new(config)

      @umlaut_request = fake_umlaut_request("/resolve?au=JAMA&genre=journal&issn=12345678")
    end
    test_with_cassette "registers proper error" do
      @service.handle(@umlaut_request)

      assert_dispatched @umlaut_request, "journal_tocs", "failed_temporary"
      assert_service_responses @umlaut_request, 'journal_tocs', :number => 0
    end
  end

end