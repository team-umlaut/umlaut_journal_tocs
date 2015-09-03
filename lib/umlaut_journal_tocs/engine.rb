require 'umlaut'
require 'bento_search'

module UmlautJournalTocs
  class Engine < ::Rails::Engine
    engine_name "umlaut_journal_tocs"

    initializer "umlaut_journal_tocs.add_service_types" do |app|
      require 'service_type_value'
      ServiceTypeValue.merge_hash!( {"journal_tocs_bento" => {}} )
    end

    initializer "umlaut_journal_tocs.backtrace_cleaner", :before => "umlaut.backtrace_cleaner" do
      Umlaut::Engine.config.whitelisted_backtrace[self.root] = self.engine_name
    end

  end
end
