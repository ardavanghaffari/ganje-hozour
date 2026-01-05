#!/bin/bash -e

webfonts="Vazirmatn:300,300italic,400,400italic,600,600italic,700,700italic"

cd $(dirname $0)
asciidoctor -a webfonts="$webfonts" -a docinfo=shared گنج_حضور.adoc