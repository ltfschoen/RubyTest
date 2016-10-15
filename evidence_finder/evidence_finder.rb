class EvidenceFinder

  def initialize(string)
    @evidence = string
  end

  def find_guilty_terms_in_evidence
    @guilty_terms = [
      /hack\.?/i,
      /ddos\.?/i
    ]
    result = []
    regex_guilty_terms = Regexp.union(@guilty_terms)
    @evidence.scan(regex_guilty_terms) do |index|
      result << [index, Regexp.last_match.offset(0)[0]]
    end
    result
  end

end