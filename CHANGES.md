# recls.Ruby - Changes <!-- omit in toc -->


## 2.13.3 - 13th August 2026

* added `# frozen_string_literal: true` to all **lib/** sources;
* documentation and project-boilerplate modernisation;
* added **AUTHORS.md**, **NEWS.md**, and **TODO.md**;
* completed **.github/workflows/ruby.yml** (OS × Ruby matrix, gem smoke, warnings job);
* implemented **Rakefile** `test` / `default` tasks;
* fixed **recls.gemspec** homepage/metadata to **recls.Ruby** (HTTPS);
* fixed `Recls.combine_paths` array slice to remain compatible with Ruby 1.9.3–2.5 (no endless ranges);
* warnings CI job now runs via `bundle exec` so development gems (e.g. **xqsr3**) are loadable;
* Ruby 4+ (incl. MinGW): pull in **fiddle** from the **Gemfile** (no longer a default gem; still required on Windows);
* documented the Ruby 4+ Windows **fiddle** requirement in **README.md** (**Installation** and **Dependencies**);
* Ruby 4+ (incl. MinGW): `Recls::Ximpl::FileStat` no longer subclasses `File::Stat` (avoids `TypeError: wrong instance allocation`);


## 2.13.2 - 25th April 2025

* fixed `Recls.combine_paths` for combining `Recls::Entry` instance(s) that may be directories;


## 2.13.1 - 2nd June 2024

* Windows-specific functionality now compatible with Ruby v2+;


## 2.13.0.1 - 21st April 2024

* substantial documentation improvements;


## 2.13.0 - 20th April 2024

* full support for `Recls::Entry` to "act as" a `String` (via its extant attribute `#to_str`), particularly to enable instances to be used in unit-test assertion statements;


## 2.12.0.1 - 20th April 2024

* added module methods `Recls.windows?`;
* compatibility with **cygwin**;


## 2.11.0.3 - 20th April 2024

* documentation improvements;


## 2.11.0.2 - 20th April 2024

* more canonicalisation of code;


## 2.11.0.1 - 20th April 2024

* canonicalisation of code;
* preparatory changes (for imminent work);


## 2.11.0 - 26th May 2020

* added alias `Recls::Entry#dir?` for `Recls::Entry#directory?`;
* added **test/scratch/test_pattern_arrays.rb**;
* improved **CHANGES.md** markup;


## 2.10.1 - 14th April 2019

* fixed (Windows-only) defect whereby searching for both `DIRECTORIES` and `FILES` caused nothing to be found;
* added **examples/find_files_and_directories.rb**;
* added **examples/find_files_and_directories.recursive.rb**;
* added explanatory .md files for all examples;
* making examples executable;
* hiding private/impl constructs from YARD;


## 2.10.0 - 14th April 2019

* added `Recls::absolute_path?`;
* added `Recls::exist?`;
* wholesale documentation markup improvements;


## 2.9.3 - 29th October 2018

* Recls.derive_relative_path() : ~ fix to defect when '.' is source;


## 2.9.2 - 19th October 2018

* warnings;


## 2.9.1 - 11th April 2019

* various tidyings;


## 2.9.0 - 21st March 2019

* compatibility with Ruby versions 1.9.3+;


## 2.8.5 - 28th January 2019

* capturing more of the extant behaviour in tests;


## 2.8.4 - 21st January 2019

* sorting out dependencies;


## 2.8.3 - 9th July 2018

* ensuring utility methods - absolute_path(), canonicalise_path(), combine_paths() - work correctly if passed Recls::Entry arguments;


## 2.8.2 - 5th February 2018

* merge;


## 2.8.1 - 27th January 2018

* Recls.combine_paths() now takes multiple path part parameters;


## 2.7.6 - 23rd January 2018

* version;


## 2.7.5 - 22nd June 2017

* fixed debug-visible warnings;


## 2.7.4 - 30th October 2016

* merge;


## 2.7.3 - 11th July 2016

* Recls::Entry properties now work, and return falsy-ish values, when executed on DETAILS_LATER non-existent entry;


## 2.7.2 - 18th June 2016

* fixed frozen string problem;


## 2.7.1 - 13th June 2016

* gem now 'recls-ruby' (rather than 'recls');


## 2.6.5 - 9th June 2016

* build_gem.sh;


## 2.6.4 - 31st May 2016

* fixed gemspec details;


## 2.6.3 - 18th April 2016

* merge;


## 2.6.2 - 29th December 2015

* implemented Recls::Entry.file_short_name and added Recls::Entry.short_path;


## 2.3.8 - 5th February 2018

* tagged release;


## 2.3.7 - 1st November 2015

* removed bodgy catch-all;


## 2.3.1 - 27th August 2015

* v2.3 : + added Recls::Entry.nlink attribute, and implemented dev and ino for Windows;


## 0.8.3 - 9th July 2018

* ensuring utility methods - absolute_path(), canonicalise_path(), combine_paths() - work correctly if passed Recls::Entry arguments;


<!-- ########################### end of file ########################### -->
