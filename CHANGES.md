# **recls.Ruby** Changes

## 2.13.1 - 2nd June 2024

* Windows-specific functionality now compatible with Ruby v2+


## 2.13.0.1 - 21st April 2024

* substantial documentation improvements


## 2.13.0 - 20th April 2024

* full support for `Recls::Entry` to "act as" a `String` (via its extant attribute `#to_str`), particularly to enable instances to be used in unit-test assertion statements


## 2.12.0.1 - 20th April 2024

* added module methods `Recls.windows?`
* compatibility with **cygwin**


## 2.11.0.3 - 20th April 2024

* documentation improvements


## 2.11.0.2 - 20th April 2024

* more canonicalisation of code


## 2.11.0.1 - 20th April 2024

* canonicalisation of code
* preparatory changes (for imminent work)


## 2.11.0 - 26th May 2020

* added alias `Recls::Entry#dir?` for `Recls::Entry#directory?`
* added **test/scratch/test_pattern_arrays.rb**


## 25th May 2020

* CHANGES.md : improved markup


## 2.10.1 - 14th April 2019

* fixed (Windows-only) defect whereby searching for both `DIRECTORIES` and `FILES` caused nothing to be found
* added **examples/find_files_and_directories.rb**
* added **examples/find_files_and_directories.recursive.rb**
* added explanatory .md files for all examples
* making examples executable
* hiding private/impl constructs from YARD


## 2.10.0 - 14th April 2019

* added `Recls::absolute_path?`
* added `Recls::exist?`
* wholesale documentation markup improvements


## previous versions

T.B.C.


<!-- ########################### end of file ########################### -->

