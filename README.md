# hxenv

[![CircleCI](https://circleci.com/gh/xolan/hxenv.svg?style=svg)](https://circleci.com/gh/xolan/hxenv)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

Simple tool to set haxelib libraries' versions as defined in `./.hxenv`

## Usage

```bash
hxenv --use
```

For additional information, see `hxenv --help`.

## .hxenv structure

Note this is strict JSON.

```json
{
    "libs": [
        {
            "name": "hxcpp",
            "version": "3.3.49"
        },
        {
            "name": "heaps",
            "version": "https://github.com/HeapsIO/heaps.git"
        }
    ]
}
```

## Building

Dependencies: haxe, haxelib

Libraries: hxcpp, hxjava, mcli

```bash
# If you already have a version of hxenv installed
hxenv --use
haxe build.hxml
# Else, check versions in .hxenv
haxelib install hxcpp <version>
haxelib install hxjava <version>
haxelib install mcli <version>
haxe build.hxml
```