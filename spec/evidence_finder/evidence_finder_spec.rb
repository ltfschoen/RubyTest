require_relative '../../evidence_finder/evidence_finder'

RSpec.describe EvidenceFinder, "#find_guilty_terms_in_evidence" do

  before(:each) do
    @ef = EvidenceFinder.new("hackddoshackdangerror", "ddos", "hack", "danger", "error")
    @ef.find_guilty_terms_in_evidence
  end

  context "with evidence" do
    it "finds amount of guilty terms in evidence" do
      expect(@ef.find_guilty_terms_in_evidence.length).to eq 5
    end

    it "appends new guilty terms" do
      @ef.+("dosh")
      @ef.+("anger")
      expect(@ef.find_guilty_terms_in_evidence.length).to eq 7
    end
  end
end