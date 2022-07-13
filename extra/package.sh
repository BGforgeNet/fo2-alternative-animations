#!/bin/bash

set -xeu -o pipefail

export WINEARCH="win32"
export WINEDEBUG="-all"
extra_dir="$(realpath extra)"
bin_dir="$extra_dir/bin"
dat2a="wine $bin_dir/dat2.exe a -1"
release_dir="$(realpath release)"
file_list="$(realpath file.list)"
sets_dir=$(realpath sets)

cd "$sets_dir"
for set in $(ls); do
  dat="$set.dat"
  cd "$set"
  find . -type f | sed -e 's|^\.\/||' -e 's|\/|\\|g' | sort > "$file_list"
  $dat2a "$sets_dir/$dat" @"$file_list"
  cd ..
done
