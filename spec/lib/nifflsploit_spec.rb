require 'nifflsploit'

describe Nifflsploit do
  describe '#cve_search' do
    before do
      @result = Nifflsploit.cve_search("CVE-2007-4387")
    end # before
    
    it 'queries for a CVE and returns a result' do
      @result.should be_kind_of(Nifflsploit::Result)
    end # it
  end # describe
end # describe Nifflsploit