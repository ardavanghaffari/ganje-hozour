#!/bin/bash -e

webfonts="Vazirmatn:300,300italic,400,400italic,600,600italic,700,700italic"

cd $(dirname $0)

build="$(pwd)/build"
docs="$(pwd)/src/docs"

rm -rf "$build"
mkdir -p "$build"

find "$docs" -type f -name '*.adoc' -print0 |
  while IFS= read -r -d '' file; do

    echo "Processing $file"

    relative_path="${file#"$docs"/}"
    output_dir="$build/$(dirname "$relative_path")"

    mkdir -p "$output_dir"

    asciidoctor \
      -a webfonts="$webfonts" \
      -a docinfodir="$docs" \
      -a docinfo=shared \
      -D "$output_dir" \
      "$file"
  done
