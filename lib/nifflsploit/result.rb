require 'nokogiri'

class Nifflsploit
  class Result
    attr_accessor :name, :rank, :authors, :references, :development, :module_options, :targets, :similar_modules
    
    def self.parse(document)
      @document = document
      @result = Nifflsploit::Result.new
      @result.name = @document.xpath("/html/body/div/div/section/h1").text
      h2s = @document.xpath("/html/body/div/div/section/div/h2")
      count = 1
      for h2 in h2s
        ul = @document.xpath("/html/body/div/div/section/div/ul[#{count}]")
        self.parse_by_h2(h2, ul)
        count += 1
      end # for h2
      
      return @result
    end # def parse
    
    private
    def self.parse_by_h2(h2, ul)
      case h2.text
      when "Exploit Rank", "Rank"
        @result.rank = ul.xpath("li").text
      when "Exploit Authors", "Authors"
        # this xpath resolves to multiple authors, looking like [Author, Author], so we need to get the text
        #  value for each author and return an array of authors
        @result.authors = ul.xpath("li").collect {|li| li.text}
      when "Vulnerability References"
        # same as above, but we need the href attribute, not the text, so we need to navigate to the 'a' object
        #  and get the href link text
        @result.references = ul.xpath("li").collect {|li| li.xpath("a").attr('href').text}
      when "Exploit Targets", "Targets"
        @result.targets = ul.xpath("li").collect {|li| li.text}
      when "Exploit Development", "Development"
        # result.development will look like {:source_code => "http://blarg.com", :history => "http://blarg2.com"}
        @result.development = {}
        for link in ul.xpath("li")
          key = link.xpath("a").text.downcase.gsub(/\s/, "_")
          value = link.xpath("a").attr('href').text
          @result.development[key.to_sym] = value
        end # for link
      when "Similar Exploit Modules", "Similar Modules"
        @result.similar_modules = {}
        for link in ul.xpath("li")
          key = link.xpath("a").text.downcase.gsub(/\s/, "_")
          value = link.xpath("a").attr('href').text
          @result.similar_modules[key.to_sym] = value
        end # for link
      when "Exploit Module Options", "Module Options"
        # result.module_options will look like {:PASSWORD => "The password to reset to (default: admin)", :Proxies => "proxy"}
        @result.module_options = {}
        for row in @document.xpath("/html/body/div/div/section/div/div[2]/table/tr")
          key = row.xpath('td[1]').text
          value = row.xpath('td[2]').text
          @result.module_options[key.to_sym] = value
        end # for row
      end # case h2.text
    end # def self.parse_by_h2
  end # class Result
end # class Nifflsploit