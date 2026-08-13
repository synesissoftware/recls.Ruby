# **recls.Ruby** Changes <!-- omit in toc -->


## 2.13.3 - 13th August 2026

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


<!-- ########################### end of file ########################### -->
