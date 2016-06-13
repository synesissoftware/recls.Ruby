@echo off

echo Executing all ruby tests, each in a separate process:
for %i in (*.rb) do @ruby "%i"

