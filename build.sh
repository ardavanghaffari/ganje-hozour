#!/bin/bash -e

webfonts="Vazirmatn:300,300italic,400,400italic,600,600italic,700,700italic"

cd $(dirname $0)

build="$(pwd)/build"

rm -rf "$build"
mkdir -p "$build"

find src/docs -type f -name '*.adoc' -print0 |
  xargs -0 asciidoctor \
    -D "$build" \
    -a webfonts="$webfonts" \
    -a docinfo=shared
