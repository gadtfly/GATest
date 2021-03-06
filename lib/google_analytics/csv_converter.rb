require 'csv'
 
class String
  def camel_case
    words = self.split.map(&:capitalize)
    words.first.downcase!
    words.join
  end
end
 
module GoogleAnalytics
  class CSVConverter
    # https://developers.google.com/analytics/devguides/platform/cost-data-import#dims_mets
    VALID_HEADERS = %w( source
                        medium
                        campaign
                        adwordsCampaignId
                        adGroup
                        keyword
                        adMatchedQuery
                        adContent
                        referralPath
                        adwordsCriteriaId
                        adSlot
                        adSlotPosition
                        adDisplayUrl
                        adDestinationUrl
                        adCost
                        adClicks
                        impressions )
 
    SKIP_LINES = /^Total|^"Keyword/
 
    CSV::HeaderConverters[:best_try] = lambda do |header|
      valid_header = VALID_HEADERS.find do |valid|
        [header.camel_case, "ad #{header}".camel_case].include?(valid)
      end
      "ga:#{valid_header}" if valid_header
    end
    
    def initialize(file)
      @table = CSV.new(file.read, headers:            true,
                                  header_converters:  :best_try,
                                  converters:         :all,
                                  skip_lines:         SKIP_LINES).read.by_col.delete_if { |k,v| k.nil? }
    end

    def to_s
      @table.to_s
    end
  end
end
