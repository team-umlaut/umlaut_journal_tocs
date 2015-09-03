require "umlaut_journal_tocs/engine"

module UmlautJournalTocs

  # Custom visibility logic for our resolve section, 
  # we don't want to show at all if it's not a suitable citation,
  # otherwise :in_progress logic. 
  SectionVisibilityLogic = lambda do |section_renderer|
    return false unless JournalTocsAdapter.suitable_citation?(section_renderer.request)

    # :in_progress logic
    return (! section_renderer.responses_empty?) || section_renderer.services_in_progress?  
  end


  def self.resolve_section_definition
    {
      :div_id     => "journal_tocs_bento",
      :html_area  => :main,
      :partial    => "umlaut_journal_tocs/resolve_section",
      :service_type_values => [:journal_tocs_bento],
      :visibility => SectionVisibilityLogic
    }
  end

end
