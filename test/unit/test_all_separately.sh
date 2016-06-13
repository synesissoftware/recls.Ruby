#!/bin/bash

echo "Executing all ruby tests, each in a separate process:"
find . -name '*.rb' -depth 1 -exec ruby {} \;


