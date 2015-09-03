# A bento_search item decorator customizing display for use in umlaut
# recent articles. 

class UmlautJournalTocsDecorator < BentoSearch::StandardDecorator

    # Always full publication date
    def display_date
      if self.publication_date
        I18n.localize(self.publication_date, :format => "%d %b %Y")
      elsif self.year
        self.year.to_s
      else
        nil
      end
    end

    # Replace link with openurl pointing to ourselves with direct-to-fulltext,
    # or else nothing. 
    def link
      if good_openurl?
        self_openurl("umlaut.skip_resolve_menu_for_type" => "fulltext")
      else
        nil
      end
    end

    #def other_links
    #  links = []
    #
    #  if good_openurl?
    #    links << BentoSearch::Link.new(:label => _h.umlaut_config.app_name, :url => self_openurl)
    #  end
    #end

    # helper method for ourselves, do we have enough
    # metadata for a good article openurl?
    def good_openurl?
      self.doi.present? || self.pmid.present? || 
      (self.volume.present? && self.issue.present? && self.start_page.present?)
    end

    def self_openurl(extra_params = {})
        _h.url_for_with_co(
            { :controller => "/resolve", 
              :action => :index
            }.merge(extra_params),  
            self.to_openurl)
    end

end