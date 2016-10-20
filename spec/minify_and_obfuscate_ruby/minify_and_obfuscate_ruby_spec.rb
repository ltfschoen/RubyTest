require_relative '../../minify_and_obfuscate_ruby/main'

RSpec.describe MinifyAndObfuscateRuby, "#minify_and_obfuscate_ruby" do

  context "with ruby source code" do

    it "removes old outputs files used for debugging" do
      # pending
    end

    it "generates output_minified_and_obfuscated.rb when it does not exist based on source code with each line reversed and some syntax substituted" do
      # pending
    end

    it "regenerates output_unminified_and_unobfuscated.rb based on obfuscated and minified version output_minified_and_obfuscated.rb if it exists" do
      # pending
    end

    it "output_minified_and_obfuscated.rb should not contain the text main.rb, main.sh, or output_minified_and_obfuscated.rb" do
      # pending
    end

    it "output_unminified_and_unobfuscated.rb should not simply contain the text dne" do
      # pending
    end

  end
end

output_file="./output_minified_and_obfuscated.rb"
output_file_recovered="./output_unminified_and_unobfuscated.rb"