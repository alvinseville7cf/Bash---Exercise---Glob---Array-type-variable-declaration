#!/usr/bin/env bash

list=("var x = new int[1] { 1 }" "var x = new int[1] { 1, }" "var x = new int[1] { 1, 2 }")

integerNumberGlob='?(-|+)+([[:digit:]])?(u|ul|lu)'
floatingNumberGlob='?(-|+)+([[:digit:]])?(.+([[:digit:]]))?(d|f|m)'
charGlob="'?'"
stringGlob='"*"'
nullGlob='null'
valueGlob="@($integerNumberGlob|$floatingNumberGlob|$charGlob|$stringGlob|$nullGlob)"

initializerGlob="{*(*([[:space:]])$valueGlob*([[:space:]]),)?(*([[:space:]])$valueGlob*([[:space:]]))}"

identifierGlob='[[:alpha:]]*([[:alnum:]])'
typeGlob="$identifierGlob"

glob="$typeGlob+([[:space:]])$identifierGlob*([[:space:]])=*([[:space:]])new+([[:space:]])$typeGlob*([[:space:]])\[*([[:space:]])$integerNumberGlob*([[:space:]])\]*([[:space:]])?($initializerGlob)"

shopt -s nocasematch
for i in "${list[@]}"
do
  [[ "$i" == $glob ]] && echo $i || continue
done
