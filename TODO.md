# recls.Ruby - TODO <!-- omit in toc -->


## Functional improvements

* \<none>


## Performance improvements

* \<none>


## Packaging improvements

* [x] ~~~complete **.github/workflows/ruby.yml** (matrix, gem smoke, warnings job) to match **xqsr3**~~~;
* [x] ~~~implement **Rakefile** `test` / `default` tasks for `bundle exec rake test`~~~;
* [x] ~~~fix **recls.gemspec** metadata URIs and homepage to **recls.Ruby** (HTTPS)~~~;
* [x] ~~~rename gemspec so the filename stem matches `spec.name` (`recls.gemspec` → **recls-ruby.gemspec**)~~~;
* [x] ~~~obtain a **run_all_unit_tests.sh** (from **misc-dev-scripts**) that skips `tput` when `$TERM` is unset or stdout is not a TTY (CI: `tput: No value for $TERM and no -T specified`)~~~;
* [x] ~~~after this packaging/boilerplate/CI lift: bump **VERSION** to **2.13.4** and align the gem~~~;


<!-- ########################### end of file ########################### -->
