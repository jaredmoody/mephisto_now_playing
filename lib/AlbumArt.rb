require 'net/http'
require 'uri'
require 'cgi'
require 'rexml/document'

AMZN_KEY = "1KH003ZTSNB9T4ENTZR2"
ASSOC_KEY = "mybl06a-20"
class AlbumArt
  
  attr_accessor :img, :url, :result, :doc
  
  def initialize(artist, album)   
    # address to map
    @search = CGI::escape(artist+','+album)
  end
  
  def find
     # build the string with the key and search keywords
	   request = "http://ecs.amazonaws.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=#{AMZN_KEY}&Operation=ItemSearch&AssociateTag=#{ASSOC_KEY}&Version=2007-01-15&SearchIndex=Music&Keywords=#{@search}&ResponseGroup=Small,Images"
  	
  	# make the query to amazon
	  @result = Net::HTTP.get URI.parse(request)
	
	  # parse the xml response
	  @doc = REXML::Document.new(result)

	  @url = REXML::XPath.first(@doc.root, "Items/Item/DetailPageURL")
    @img = REXML::XPath.first(@doc.root, "Items/Item/MediumImage/URL")
	  
	  @img = img.get_text.to_s unless @img.nil?
	  @url = CGI::unescape url.get_text.to_s unless @url.nil?

	  return (!@img.nil? && !@url.nil?)
  end	
end