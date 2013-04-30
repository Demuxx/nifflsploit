require 'nokogiri'

class Nifflsploit
  class Result
    attr_accessor :name, :rank, :authors, :references, :development, :module_options
    
    def self.parse(document)
      result = Nifflsploit::Result.new
      result.name = document.xpath("/html/body/div/div/section/h1").text
      result.rank = document.xpath("/html/body/div/div/section/div/ul[1]/li").text
      
      # this xpath resolves to multiple authors, looking like [Author, Author], so we need to get the text
      #  value for each author and return an array of authors
      result.authors = document.xpath("/html/body/div/div/section/div/ul[2]/li").collect {|z| z.text}
      
      # same as above, but we need the href attribute, not the text, so we need to navigate to the 'a' object
      #  and get the href link text
      result.references = document.xpath("/html/body/div/div/section/div/ul[3]/li").collect {|z| z.xpath("a").attr('href').text}
      
      # result.development will look like {:source_code => "http://blarg.com", :history => "http://blarg2.com"}
      result.development = {}
      for link in document.xpath("/html/body/div/div/section/div/ul[4]/li")
        key = link.xpath("a").text.downcase.gsub(/\s/, "_")
        value = link.xpath("a").attr('href').text
        result.development[key.to_sym] = value
      end # for link
      
      # result.module_options will look like {:PASSWORD => "The password to reset to (default: admin)", :Proxies => "proxy"}
      result.module_options = {}
      for row in document.xpath("/html/body/div/div/section/div/div[2]/table/tr")
        key = row.xpath('td[1]').text
        value = row.xpath('td[2]').text
        result.module_options[key.to_sym] = value
      end # for row
      
      return result
    end # def parse
  end # class Result
end # class Nifflsploit