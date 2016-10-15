require_relative '../../evidence_finder/evidence_finder'

RSpec.describe EvidenceFinder, "#find_guilty_terms_in_evidence" do

  before(:each) do
    @ef = EvidenceFinder.new("hackddoshackddos")
  end

  context "with evidence" do

    it "finds amount of guilty terms in evidence" do
      expect(@ef.find_guilty_terms_in_evidence.length).to eq 4
    end
  end
end