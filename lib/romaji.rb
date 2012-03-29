# coding: utf-8
require 'romaji/version'
require 'nkf'
require 'romaji/string_extension'
require 'romaji/constants'

module Romaji
  def self.romaji2kana(text, options = {})
    text = hira2kata(normalize(text))
    pos = 0
    k = nil
    kana = ''
    while true
      3.downto(1) do |t|
        substr = text.slice(pos, t)
        k = ROMAN2KANA[substr]
        if k
          kana += k
          pos += t
          break
        end
      end
      unless k
        kana += text.slice(pos, 1)
        pos += 1
      end
      break if pos >= text.size
    end

    kana_type = options[:kana_type] || :katakana
    kana = kata2hira(kana) if :hiragana == kana_type.to_sym
      
    return kana
  end

  def self.kana2romaji(text)
    NKF.nkf("--katakana -Ww", text)
    return 'kyoumoshinaitone'
  end

  def self.hira2kata(text)
    NKF.nkf("--katakana -Ww", text)
  end

  def self.kata2hira(text)
    NKF.nkf("--hiragana -Ww", text)
  end

  def self.normalize(text)
    NKF.nkf('-mZ0Wwh0', text).downcase
  end
end
