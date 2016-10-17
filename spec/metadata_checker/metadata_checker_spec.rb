require_relative '../../metadata_checker/metadata_checker'

RSpec.describe MetadataChecker, "#metadata_checker" do

  context "with metadata_expression" do

    it "invalidate syntax detected returns empty array when expression is not supported due to containing inner parenthesis" do
      metadata_expression = "{ () () }"
      @mc = MetadataChecker.new(metadata_expression)
      expect(@mc.validate_syntax_for(@mc.metadata).length).to be 0
    end

    it "validates syntax by returning an array with matched valid expression and index when expression is supported" do
      metadata_expression = "{ {} {} {} }"
      @mc = MetadataChecker.new(metadata_expression)
      expect(@mc.validate_syntax_for(@mc.metadata)[0]).to_not be nil
    end
  end
end