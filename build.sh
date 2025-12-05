#!/bin/bash
rm -rf ./.haxelib

haxe buildsys.hxml

if (($? == 0))
then
  node build "$@"
fi