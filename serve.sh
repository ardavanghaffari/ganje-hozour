#!/bin/bash -e

cd "$(dirname "$0")/build"
python3 -m http.server 8000
