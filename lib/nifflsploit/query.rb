require 'open-uri'
require 'cgi'
require 'nokogiri'

class Nifflsploit
  class Query
    BASE_URL = "http://www.metasploit.com/modules/framework/search?cve="
    
    def self.cve(cve)
      url = BASE_URL+CGI::escape(cve)
      response = fetch_html(url)
      document = Nokogiri::HTML.parse(response)
      return document
    end # def self.cve
    
    private
    def self.fetch_html(url)
      # open is the open-uri, which returns a io-string object, so we need to convert that to a encoded string
      response = open(url)
      
      # open-uri will save the response as a temp file if it's too large, so check what the class is before parsing
      if response.kind_of?(StringIO)
        resp_string = response.string
      else
        resp_string = response.read
      end
      return resp_string
    end # def fetch
  end # class Query
end # class Nifflsploit