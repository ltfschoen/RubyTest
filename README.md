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
require_relative './robot_system/main'
require_relative './thread_system/main'
```
- Experiment with reference to code used in "Example Usage"

Example Usage:
- Run exercise_system with `ruby ./exercise_system/main.rb`
- Run accounting_system with `ruby ./accounting_system/main.rb`
- Run Ruby minify and obfuscate, and then unminify and unobfuscate: `cd minify_and_obfuscate_ruby && ruby ./main.rb; ruby ./main.rb`. Inspect the outputs files generated in folder ./minify_and_obfuscate_ruby/outputs, and then reset by running `ruby ./main.rb` a third time or with `rm -rf outputs` and repeat these steps. IMPORTANT NOTE: Calling shell script from `ruby main.rb` prevents echo's and prompts for user input from showing up in Bash. They only appear when run with `sh main.rb`.
- Run mathgame: `ruby mathgame/game.rb`
