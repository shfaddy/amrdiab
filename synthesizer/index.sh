#!/usr/bin/env bash

tempo=105
depth=3
increment=1
octave=2
range=3

node malfuf.mjs \
tempo $tempo \
depth $depth \
increment $increment \
octave $octave \
range $range \
> ~/music.nota

csound index.csd #-o maqsum.t75.d$depth.wav
