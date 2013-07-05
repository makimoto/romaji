# Romaji

[![Build Status](https://secure.travis-ci.org/makimoto/romaji.png?branch=master)](http://travis-ci.org/makimoto/romaji)

Yet another Romaji-Kana transliterator.

## Installation

    $ gem install romaji

## Usage
    require "romaji"
    Romaji.kana2romaji "スシ" #=> "sushi"
    Romaji.romaji2kana "sushi" #=> "スシ"
    Romaji.romaji2kana "sushi", :kana_type => :hiragana #=> "すし"

    require "romaji/core_ext/string"
    "sushi".kana #=> "スシ"
    "スシ".romaji #=> "sushi"
    a = "sushi"
    a.kana!
    p a #=> "スシ"
    a.romaji!
    p a #=> "sushi"


## Author

Shimpei Makimoto
