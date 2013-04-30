require 'nifflsploit/query'
require 'nifflsploit/result'

class Nifflsploit
  def self.cve_search(cve)
    response = Nifflsploit::Query.cve(cve)
    result = Nifflsploit::Result.parse(response)
    return result
  end # def cve_search
end # class Nifflsploit