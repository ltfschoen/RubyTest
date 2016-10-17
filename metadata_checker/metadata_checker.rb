class MetadataChecker

  # Define default Getter methods, but not Setter methods
  attr_reader :metadata

  # Delegate to Setter methods instead of set instance variables directly.
  def initialize(metadata)
    self.metadata = metadata
  end

  # Setter method enforces rules
  def metadata=(metadata)
    @metadata = metadata
  end

  def validate_syntax_for(metadata_expression)
    # brace expression is an open brace then sequence of zero or more chars or brace expressions (nested parenthesis are not allowed), then a closing brace
    regex_valid_syntax = /
      \A                            # from start of string
        (?<brace_expression>        # create a group named brace_expression
          {                         # start of the brace_expression
            (                       # zero or more occurrences of parenthesis and inner contents
              [^()]                 # anything but parenthesis inside the braces
            |                       # or
              \g<brace_expression>  # nested brace expression
            )*
          }
        )
      \Z                            # until end of string
    /x                              # allow writing understandable expression with indentation

    result = []
    @metadata.scan(regex_valid_syntax) do |index|
      result << [index, Regexp.last_match.offset(0)[0]]
    end
    result
  end


end
