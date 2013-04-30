require 'nokogiri'
require 'nifflsploit/query'

describe Nifflsploit::Query do
  describe '#cve' do
    context 'with a valid cve id' do
      it 'returns an HTML Document object' do
        result = Nifflsploit::Query.cve("CVE-2007-4387")
        result.should be_kind_of(Nokogiri::HTML::Document)
      end # it
    end # context
    
    
    context 'with an invalid cve id' do
      it 'returns an HTML Document object' do
        result = Nifflsploit::Query.cve("CVE-200-4387")
        result.should be_kind_of(Nokogiri::HTML::Document)
      end # it
    end # context
  end # describe cve 
end # describe Nifflsploit