require 'nokogiri'
require 'open-uri'
require 'nifflsploit/Result'

describe Nifflsploit::Result do
  context 'with a valid response' do
    before do
      file = open("spec/support/positive_response.html")
      response = Tempfile.new("temp")
      response.write(file.read)
      response.rewind
      result = Nokogiri::HTML.parse(response)
      response.unlink
      @result = Nifflsploit::Result.parse(result)
    end # before
    
    it 'returns the CVE name' do
      @result.name.should eq("2Wire Cross-Site Request Forgery Password Reset Vulnerability")
    end # it
    
    it 'returns the exploit rank' do
      @result.rank.should eq("Normal")
    end # it
    
    it 'returns the exploit authors' do
      @result.authors.should be_kind_of(Array)
      @result.authors.first.should eq("hkm < hkm [at] hakim.ws >")
    end # it
    
    it 'returns Vulnerability Reference links' do
      @result.references.should be_kind_of(Array)
      @result.references.first.should eq("http://cvedetails.com/cve/2007-4387/")
    end # it
    
    it 'returns Development links' do
      @result.development.should be_kind_of(Hash)
      @result.development[:source_code].should eq("http://dev.metasploit.com/redmine/projects/framework/repository/entry/modules/auxiliary/admin/2wire/xslt_password_reset.rb")
    end # it
    
    it 'returns Module Options hash' do
      @result.module_options.should be_kind_of(Hash)
      @result.module_options[:PASSWORD].should eq("The password to reset to (default: admin)")
    end # it
  end # context
  
  context 'with an invalid response' do
    before do
      document = Nokogiri::HTML::Document.new
      @result = Nifflsploit::Result.parse(document)
    end # before
    
    it 'returns an empty result object' do
      @result.name.should be_empty
      @result.rank.should be_empty
      @result.authors.should be_empty
      @result.references.should be_empty
      @result.development.to_a.should be_empty
      @result.module_options.to_a.should be_empty
    end # it
  end # context
end # describe