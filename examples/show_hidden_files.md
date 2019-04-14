# recls.Ruby Example - **show_hidden_files**

## Summary

TBC

## Source

```ruby
#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

# To find only hidden files, need to:
#
# 1. Ensure that they are returned in search, by including Recls::SHOW_HIDDEN
# 2. Filter returned entries by hidden? attribute
Recls.file_rsearch('.', Recls::WILDCARDS_ALL, Recls::FILES | Recls::SHOW_HIDDEN).each do |fe|

	puts fe.path if fe.hidden?
end
```

## Discussion

TBC

## Example results

```
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.gitignore
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.ruby-version
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.ruby-version-exclusions
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/test/fixtures/hidden/.file-1
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/test/fixtures/hidden/.file-2
```

