require 'test_helper'

class ControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false 
  extend TestWithCassette

  setup do
    @controller = ResolveController.new
  end

  test_with_cassette("gets results") do
    get :index, {"issn" => "17588936"}

    assert_response :success

    # Has at least one response item in the classes we expect
    sample_item = assert_select(".umlaut-section.journal_tocs_bento .response_list .response_item .bento_item")

    assert_select(sample_item, "a.response_link")
    assert_select(sample_item, ".abstract")

    # Has a list_with_limit 
    assert_select(".journal_tocs_bento .collapsible")
  end

  test_with_cassette("not for article-level") do
    get :index, { jtitle: 'JAMA', genre: 'article', issn: '1538-3598', volume: '1', issue: '1', spage:'1'}

    # No response content
    sample_item = assert_select(".umlaut-section.journal_tocs_bento .response_list .response_item .bento_item", false)

    # TODO: No section on page at all. 
  end

end