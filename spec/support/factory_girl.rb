# RSpec without Rails
# http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md
RSpec.configure do |config|
  # avoid needing to prefaced factory_girl methods with `FactoryGirl`
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    # FactoryGirl.definition_file_paths = %w("../../spec/factories")
    FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]

    # Factories automatically loaded if factories defined in files: spec/factories/*.rb
    FactoryGirl.find_definitions
  end
end