#!/bin/bash -e

webfonts="Vazirmatn:300,300italic,400,400italic,600,600italic,700,700italic"

cd $(dirname $0)
find . -type f -name '*.adoc' -print0 |
  xargs -0 asciidoctor \
    -a webfonts="$webfonts" \
    -a docinfo=shared
