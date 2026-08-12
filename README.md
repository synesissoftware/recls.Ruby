# recls.Ruby <!-- omit in toc -->

**rec**-ursive **ls**, for Ruby

![Language](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Gem Version](https://badge.fury.io/rb/recls-ruby.svg)](https://badge.fury.io/rb/recls-ruby)
[![Last Commit](https://img.shields.io/github/last-commit/synesissoftware/recls.Ruby)](https://github.com/synesissoftware/recls.Ruby/commits/master)
[![Ruby](https://github.com/synesissoftware/recls.Ruby/actions/workflows/ruby.yml/badge.svg)](https://github.com/synesissoftware/recls.Ruby/actions/workflows/ruby.yml)


## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Installation](#installation)
- [Components](#components)
	- [The ``Recls`` module](#the-recls-module)
	- [The ``Recls::Entry`` class](#the-reclsentry-class)
- [Examples](#examples)
- [Project Information](#project-information)
	- [Where to get help](#where-to-get-help)
	- [Contribution guidelines](#contribution-guidelines)
	- [Dependencies](#dependencies)
		- [Efferent (fan-out)](#efferent-fan-out)
			- [Runtime Dependencies (aka "Normal Dependencies")](#runtime-dependencies-aka-normal-dependencies)
			- [Development Dependencies](#development-dependencies)
		- [Afferent (fan-in)](#afferent-fan-in)
			- [Runtime dependents](#runtime-dependents)
			- [Development dependents](#development-dependents)
	- [Related projects](#related-projects)
	- [License](#license)
	- [Compatibility](#compatibility)


## Introduction

**recls** stands for **rec**-ursive **ls**. The first recls library was a C
library with a C++ wrapper. There have been several implementations in other
languages. **recls.Ruby** is the Ruby version.


## Installation

Install via **gem** as in:

```
gem install recls-ruby
```

or add it to your `Gemfile`.


## Components

The main components of **recls.Ruby** are:

* the ``Recls`` module; and
* the ``Recls::Entry`` class.


### The ``Recls`` module

The ``Recls`` module is the primary API surface. Significant facilities include:

* path utilities — `Recls.absolute_path`, `Recls.absolute_path?`, `Recls.canonicalise_path`, `Recls.combine_paths`, `Recls.derive_relative_path`;
* existence / type probes — `Recls.directory?`, `Recls.exist?`, `Recls.file?`, `Recls.stat`;
* search — `Recls.search` (non-recursive) and `Recls.rsearch` (recursive), returning enumerables of ``Recls::Entry``;
* line-oriented search — `Recls.foreach`;
* ambient OS helpers — `Recls.windows?`, plus constants such as `Recls::PATH_NAME_SEPARATOR`, `Recls::PATH_SEPARATOR`, and `Recls::WILDCARDS_ALL`.


### The ``Recls::Entry`` class

This class represents a file-system entry, and is created either by the `Recls.stat()` method, or is returned from the searches (see above). It has the following (simplified) interface:

```Ruby
module Recls

  # A file-system entry
  class Entry

    # ##########################
    # Name-related attributes

    # (+String+) A normalised form of {.path} that can be used in comparisons
    attr_reader :compare_path
    # (+String+) The full-path of the instance
    attr_reader :path
    # (+String+) The (Windows) short-form of {.path}, or +nil+ if not on Windows
    attr_reader :short_path
    # (+String+) The (Windows) drive. +nil+ if does not exist
    attr_reader :drive
    # (+String+) The full path of the entry's directory (taking into account the {.drive} if on Windows)
    attr_reader :directory_path
    alias_method :dirname, :directory_path
    # (+String+) The entry's directory (excluding the {.drive} if on Windows)
    attr_reader :directory
    # ( +[+ +String+ +]+ ) An array of directory parts, where each part ends in {Recls::PATH_NAME_SEPARATOR}
    attr_reader :directory_parts
    # (+String+) The entry's file name (combination of {.stem} + {.extension})
    attr_reader :file_full_name
    # (+String+) The (Windows) short-form of {.basename}, or +nil+ if not on Windows
    attr_reader :file_short_name
    alias_method :basename, :file_full_name
    # (+String+) The entry's file stem
    attr_reader :file_name_only
    alias_method :stem, :file_name_only
    # (+String+) The entry's file extension
    attr_reader :file_extension
    alias_method :extension, :file_extension
    # (+String+) The search directory if specified; +nil+ otherwise
    attr_reader :search_directory
    # (+String+) The +#path+ relative to {.search_directory}; +nil+ if no search directory specified
    attr_reader :search_relative_path
    # (+String+) The +#directory+ relative to {.search_directory}; +nil+ if no search directory specified
    attr_reader :search_relative_directory
    # (+String+) The +#directory_path+ relative to {.search_directory}; +nil+ if no search directory specified
    attr_reader :search_relative_directory_path
    # ( +[+ +String+ +]+ ) The +#directory_parts+ relative to {.search_directory}; +nil+ if no search directory specified
    attr_reader :search_relative_directory_parts

    # ##########################
    # Nature attributes

    # indicates whether the given entry existed at the time the entry
    # instance was created
    def exist?
      . . .
    end

    # indicates whether the given entry is hidden
    def hidden?
      . . .
    end

    # indicates whether the given entry is readonly
    def readonly?
      . . .
    end

  if Recls::Ximpl::OS::OS_IS_WINDOWS

    # (*WINDOWS-ONLY*) Indicates whether the entry has the *system* bit
    def system?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry has the *archive* bit
    def archive?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry is a device
    def device?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry is *normal*
    def normal?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry has the *temporary* bit
    def temporary?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry has the *compressed* bit
    def compressed?
      . . .
    end

    # (*WINDOWS-ONLY*) Indicates whether the entry has the *encrypted* bit
    def encrypted?
      . . .
    end
  end

    # indicates whether the given entry represents a directory
    def directory?
      . . .
    end

    alias_method :dir?, :directory?

    # indicates whether the given entry represents a file
    def file?
      . . .
    end

    # indicates whether the given entry represents a link
    def link?
      . . .
    end

    # indicates whether the given entry represents a socket
    def socket?
      . . .
    end

    # ##########################
    # Size attributes

    # indicates the size of the given entry
    def size
      . . .
    end

    # ##########################
    # File-system entry attributes

    # indicates the device of the given entry
    #
    # On Windows, this will be 0 if the entry cannot be opened
    def dev
      . . .
    end

    # indicates the ino of the given entry
    #
    # On Windows, this will be 0 if the entry cannot be opened
    def ino
      . . .
    end

    # number of links to the given entry
    #
    # On Windows, this will be 0 if the entry cannot be opened
    def nlink
      . . .
    end

    # ##########################
    # Time attributes

    # indicates the last access time of the entry
    def last_access_time
      . . .
    end

    # indicates the modification time of the entry
    def modification_time
      . . .
    end

    # ##########################
    # Comparison

    # determines whether rhs is an instance of {Recls::Entry} and refers to
    # the same path
    def eql?(rhs)
      . . .
    end

    # determines whether rhs refers to the same path
    def ==(rhs)
      . . .
    end

    # compares this instance with rhs
    def <=>(rhs)
      . . .
    end

    # the hash
    def hash
      . . .
    end

    # ##########################
    # Conversion

    # represents the entry as a string (in the form of the full path)
    def to_s
      . . .
    end

    # represents the entry as a string (in the form of the full path)
    def to_str
      . . .
    end
  end # class Entry
end # module Recls
```


## Examples

Examples are provided in the ```examples``` directory, along with a markdown description for each. A detailed list TOC of them is provided in [EXAMPLES.md](./EXAMPLES.md).


## Project Information


### Where to get help

[GitHub Page](https://github.com/synesissoftware/recls.Ruby "GitHub Page")


### Contribution guidelines

Defect reports, feature requests, and pull requests are welcome on https://github.com/synesissoftware/recls.Ruby.


### Dependencies


#### Efferent (fan-out)

Libraries upon which **recls.Ruby** depends:


##### Runtime Dependencies (aka "Normal Dependencies")

* \<none>;


##### Development Dependencies

* [**rake**](https://rubygems.org/gems/rake);
* [**test-unit**](https://rubygems.org/gems/test-unit);
* [**xqsr3**](https://rubygems.org/gems/xqsr3);


#### Afferent (fan-in)

Projects that depend on **recls.Ruby**:


##### Runtime dependents

* [**libCLImate.Ruby**](https://github.com/synesissoftware/libCLImate.Ruby);


##### Development dependents

* \<none>;


### Related projects

* [**recls**](https://github.com/synesissoftware/recls/);
* [**recls.Go**](https://github.com/synesissoftware/recls.Go/);
* [**recls.NET**](https://github.com/synesissoftware/recls.NET/);
* [**recls.Python**](https://github.com/synesissoftware/recls.Python/);


### License

**recls.Ruby** is released under the 3-clause BSD license. See [LICENSE](./LICENSE) for details.


### Compatibility

For v2.8.x onwards, **recls.Ruby** is compatible only with Ruby 2.0+; all other
past and current versions work with Ruby 1.9.3+.


<!-- ########################### end of file ########################### -->
