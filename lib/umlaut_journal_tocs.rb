require "umlaut_journal_tocs/engine"

module UmlautJournalTocs

  def self.resolve_section_definition
    {
      :div_id     => "journal_tocs_bento",
      :html_area  => :main,
      :partial    => "umlaut_journal_tocs/resolve_section",
      :service_type_values => [:journal_tocs_bento]
    }
  end

end
