References:
- http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/

Setup:
```
gem install bundler
bundle install
```

- Add/update latest RVM and add latest Ruby version
```
rvm -v
rvm get stable
rvm reload
rvm list
rvm install ruby-2.3.1
```

- Create custom local Gemset (i.e. "rubymine_2016_4_2" and add gems to it)
```
rvm ruby-2.3.1 do rvm gemset create rubymine_2016_4_2
rvm ruby-2.3.1@rubymine_2016_2_4 do gem install to_regexp
rvm ruby-2.3.1@rubymine_2016_2_4 do gem list
```

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
require_relative './metadata_checker/main'
require_relative './team_system/main'
```
- Experiment with reference to code used in "Example Usage"

Example Usage:
- Run exercise_system with `ruby ./exercise_system/main.rb`
- Run accounting_system with `ruby ./accounting_system/main.rb`