# recls.Ruby - Example - **show_hidden_files**

## Summary

Illustrates recursive searching for hidden files via `Recls::SHOW_HIDDEN` and filtering with `Recls::Entry#hidden?`.


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

  puts fe if fe.hidden?
end
```


## Discussion

By default, searches omit hidden entries. Including `Recls::SHOW_HIDDEN` causes
them to be returned; the example then keeps only those for which `#hidden?` is
true. (The older `Recls.file_rsearch` name is retained for compatibility;
`Recls.rsearch` is preferred.)


## Example results

```
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.gitignore
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.ruby-version
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/.ruby-version-exclusions
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/test/fixtures/hidden/.file-1
/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/test/fixtures/hidden/.file-2
```


<!-- ########################### end of file ########################### -->
