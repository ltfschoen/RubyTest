require_relative '../../evidence_finder/evidence_finder'

RSpec.describe EvidenceFinder, "#find_guilty_terms_in_evidence" do

  before(:each) do
    @ef = EvidenceFinder.new("hackddoshackddos", "ddos", "hack")
    @ef.find_guilty_terms_in_evidence
  end

  context "with evidence" do

    it "finds amount of guilty terms in evidence" do
      expect(@ef.find_guilty_terms_in_evidence.length).to eq 4
    end

    it "appends new guilty terms" do
      @ef.+("ckdd")
      expect(@ef.find_guilty_terms_in_evidence.length).to eq 6
    end
  end
end