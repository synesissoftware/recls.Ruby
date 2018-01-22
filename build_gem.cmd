@ECHO OFF

REM #########################################################################
REM File:       build_gem.cmd
REM
REM Purpose:    Builds the gem
REM
REM Created:    11th July 2016
REM Updated:    11th July 2016
REM
REM Author:     Matthew Wilson
REM
REM Copyright:  <<TBD>>
REM
REM #########################################################################

gem build recls.gemspec %*

