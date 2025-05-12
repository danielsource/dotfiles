#!/bin/sh

set -e

cd "$(dirname "$(readlink -f "$0")")"

mkdir -p ~/.local/bin

cc -Os -s -std=c99 -Wall -Wextra -Wpedantic -o ~/.local/bin/my-status my-status.c -lX11
