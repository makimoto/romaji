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
      Romaji::ROMAJI_MAX_LENGTH.downto(1) do |t|
        substr =  scoped_kcode('u'){text.split(//).slice(pos, t).join}
        k = ROMAJI2KANA[substr]
        if k
          kana += k
          pos += t
          break
        end
      end
      unless k
        kana += scoped_kcode('u'){text.split(//).slice(pos, 1).join}
        pos += 1
      end
      break if pos >= scoped_kcode('u'){text.split(//).size}
    end

    kana_type = options[:kana_type] || :katakana
    kana = kata2hira(kana) if :hiragana == kana_type.to_sym
      
    return kana
  end

  def self.kana2romaji(text)
    text = hira2kata(normalize(text))
    pos = 0
    k = nil
    kana = ''
    while true
      Romaji::ROMAJI_MAX_LENGTH.downto(1) do |t|
        substr =  scoped_kcode('u'){text.split(//).slice(pos, t).join}
        k = KANA2ROMAJI[substr]
        if k
          kana += k[0]
          pos += t
          break
        end
      end
      unless k
        kana += scoped_kcode('u'){text.split(//).slice(pos, 1).join}
        pos += 1
      end
      break if pos >= scoped_kcode('u'){text.split(//).size}
      #text = hira2kata(normalize(text))
      #return 'kyoumoshinaitone'
    end
    kana
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

  def self.scoped_kcode(kcode)
    if RUBY_VERSION == '1.8.7'
      origin = $KCODE
      $KCODE = kcode
      result = yield
      $KCODE = origin
    else
      result = yield
    end
    result
  end
end
