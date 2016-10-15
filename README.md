References:
- http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/

Setup:
- `bundle install`

Unit Tests:
- Run unit tests with `rspec`
*Note: [Raised Mixin issue on StackOverflow](https://stackoverflow.com/questions/40052573/unable-to-call-ruby-mixin-instance-method-from-rspec)*

Experimentation:
- Run Interactive Ruby: `irb`
- Run/Import
```
require_relative './accounting_system/main'
require_relative './exercise_system/main'
require_relative './word_list/main'
require_relative './file_list/main'
require_relative './mixins/debug'
require_relative './evidence_finder/main'
```
- Experiment with reference to code used in "Example Usage"

Example Usage:
- Run exercise_system with `ruby ./exercise_system/main.rb`
- Run accounting_system with `ruby ./accounting_system/main.rb`