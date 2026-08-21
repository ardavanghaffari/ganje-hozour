#!/bin/bash -e

webfonts="Vazirmatn:300,300italic,400,400italic,600,600italic,700,700italic"

cd $(dirname $0)

ROOT=$(pwd)
BUILD="$ROOT/build"
MEDIA="$ROOT/media"

rm -rf "$BUILD"
mkdir -p "$BUILD"

if [ -z "$CI" ]; then
  ln -s "$MEDIA" "$BUILD/media"
fi

find . -type f -name '*.adoc' -print0 |
  xargs -0 asciidoctor \
    -D "$BUILD" \
    -a webfonts="$webfonts" \
    -a docinfo=shared
