#!/bin/bash

set -xeu -o pipefail

extra_dir="$(realpath extra)"
bin_dir="$extra_dir/bin"
sets_dir="$(realpath sets)"

DAT3_VERSION="v0.11.1"
dat3_url="https://github.com/BGforgeNet/dat3/releases/download/${DAT3_VERSION}/dat3"
dat3="$bin_dir/dat3"
# zlib level for every .dat: 6 packs in under half the time of 9, for archives about 1% larger.
dat3_level=6

# Download dat3 tool if it doesn't exist
if [[ ! -f "$dat3" ]]; then
  mkdir -p "$bin_dir"
  wget -q "$dat3_url" -O "$dat3"
  chmod +x "$dat3"
fi

# Release asset names are the set names; other mods fetch them by name.
for set_dir in "$sets_dir"/*/; do
  set_name="$(basename "$set_dir")"
  "$dat3" a -c "$dat3_level" -C "$set_dir" "$sets_dir/$set_name.dat" '*'
done
