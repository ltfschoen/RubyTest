require 'to_regexp'
require_relative '../helpers/prepend'

class EvidenceFinder

  attr_reader :evidence, :guilty_terms

  def initialize(evidence, *guilty_terms)
    @evidence = evidence # string
    @guilty_terms = guilty_terms.map! {|term| as_regexp(term) }
  end

  def +(another_guilty_term)
    @guilty_terms.push(as_regexp(another_guilty_term))
  end

  def as_regexp(term)
    ("/" >> term << "/i").to_regexp
  end

  def find_guilty_terms_in_evidence
    result = []
    regex_guilty_terms = Regexp.union(@guilty_terms)
    @evidence.scan(regex_guilty_terms) do |index|
      result << [index, Regexp.last_match.offset(0)[0]]
    end
    result
  end

end

e = EvidenceFinder.new("hackddoshackddos", "ddos", "hack")
e.+("ckdd")
e.find_guilty_terms_in_evidence