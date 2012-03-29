# coding: utf-8
require 'romaji/version'
require 'nkf'

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

    if :katakana == kana_type.to_sym
      kana = hira2kata(kana)
    elsif :hiragana == kana_type.to_sym
      kana = kata2hira(kana)
    end
    
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

  module StringExtension
    def normalize
      Romaji.normalize(self)
    end

    def normalize!
      self.replace(self.normalize)
    end
  end

  ROMAN2KANA = {
    "a"=>"ア", "i"=>"イ", "u"=>"ウ", "e"=>"エ", "o"=>"オ", "-"=>"ー", "n" => "ン",
    "xa"=>"ァ", "xi"=>"ィ", "xu"=>"ゥ", "xe"=>"ェ", "xo"=>"ォ",
    "ka"=>"カ", "ki"=>"キ", "ku"=>"ク", "ke"=>"ケ", "ko"=>"コ",
    "ca"=>"カ", "cu"=>"ク", "co"=>"コ",
    "ga"=>"ガ", "gi"=>"ギ", "gu"=>"グ", "ge"=>"ゲ", "go"=>"ゴ",
    "sa"=>"サ", "si"=>"シ", "su"=>"ス", "se"=>"セ", "so"=>"ソ",
    "za"=>"ザ", "zi"=>"ジ", "zu"=>"ズ", "ze"=>"ゼ", "zo"=>"ゾ",
    "ja"=>"ジャ","ji"=>"ジ", "ju"=>"ジュ","je"=>"ジェ","jo"=>"ジョ",
    "ta"=>"タ", "ti"=>"チ", "tu"=>"ツ", "te"=>"テ", "to"=>"ト",
    "da"=>"ダ", "di"=>"ヂ", "du"=>"ヅ", "de"=>"デ", "do"=>"ド",
    "na"=>"ナ", "ni"=>"ニ", "nu"=>"ヌ", "ne"=>"ネ", "no"=>"ノ",
    "ha"=>"ハ", "hi"=>"ヒ", "hu"=>"フ", "he"=>"ヘ", "ho"=>"ホ",
    "ba"=>"バ", "bi"=>"ビ", "bu"=>"ブ", "be"=>"ベ", "bo"=>"ボ",
    "pa"=>"パ", "pi"=>"ピ", "pu"=>"プ", "pe"=>"ペ", "po"=>"ポ",
    "va"=>"ヴァ","vi"=>"ヴィ","vu"=>"ヴ", "ve"=>"ヴェ","vo"=>"ヴォ",
    "fa"=>"ファ","fi"=>"フィ","fu"=>"フ", "fe"=>"フェ","fo"=>"フォ",
    "ma"=>"マ", "mi"=>"ミ", "mu"=>"ム", "me"=>"メ", "mo"=>"モ",
    "ya"=>"ヤ", "yi"=>"イ", "yu"=>"ユ", "ye"=>"イェ", "yo"=>"ヨ",
    "ra"=>"ラ", "ri"=>"リ", "ru"=>"ル", "re"=>"レ", "ro"=>"ロ",
    "la"=>"ラ", "li"=>"リ", "lu"=>"ル", "le"=>"レ", "lo"=>"ロ",
    "wa"=>"ワ", "wi"=>"ヰ", "wu"=>"ウ", "we"=>"ヱ", "wo"=>"ヲ",
    "nn"=>"ン",
    "tsu"=>"ツ",
    "xka"=>"ヵ", "xke"=>"ヶ",
    "xwa"=>"ヮ", "xtsu"=>"ッ",   "xya"=>"ャ",  "xyu"=>"ュ",  "xyo"=>"ョ",
    "kya"=>"キャ", "kyi"=>"キィ", "kyu"=>"キュ", "kye"=>"キェ", "kyo"=>"キョ",
    "gya"=>"ギャ", "gyi"=>"ギィ", "gyu"=>"ギュ", "gye"=>"ギェ", "gyo"=>"ギョ",
    "sya"=>"シャ", "syi"=>"シィ", "syu"=>"シュ", "sye"=>"シェ", "syo"=>"ショ",
    "sha"=>"シャ", "shi"=>"シ",  "shu"=>"シュ", "she"=>"シェ", "sho"=>"ショ",
    "zya"=>"ジャ", "zyi"=>"ジィ", "zyu"=>"ジュ", "zye"=>"ジェ", "zyo"=>"ジョ",
    "jya"=>"ジャ", "jyi"=>"ジィ", "jyu"=>"ジュ", "jye"=>"ジェ", "jyo"=>"ジョ",
    "tya"=>"チャ", "tyi"=>"チィ", "tyu"=>"チュ", "tye"=>"チェ", "tyo"=>"チョ",
    "cya"=>"チャ", "cyi"=>"チィ", "cyu"=>"チュ", "cye"=>"チェ", "cyo"=>"チョ",
    "cha"=>"チャ", "chi"=>"チ",  "chu"=>"チュ", "che"=>"チェ", "cho"=>"チョ",
    "tha"=>"テャ", "thi"=>"ティ", "thu"=>"テュ", "the"=>"テェ", "tho"=>"テョ",
    "dya"=>"ヂャ", "dyi"=>"ヂィ", "dyu"=>"ヂュ", "dye"=>"ヂェ", "dyo"=>"ヂョ",
    "dha"=>"デャ", "dhi"=>"ディ", "dhu"=>"デュ", "dhe"=>"デェ", "dho"=>"デョ",
    "nya"=>"ニャ", "nyi"=>"ニィ", "nyu"=>"ニュ", "nye"=>"ニェ", "nyo"=>"ニョ",
    "hya"=>"ヒャ", "hyi"=>"ヒィ", "hyu"=>"ヒュ", "hye"=>"ヒェ", "hyo"=>"ヒョ",
    "bya"=>"ビャ", "byi"=>"ビィ", "byu"=>"ビュ", "bye"=>"ビェ", "byo"=>"ビョ",
    "pya"=>"ピャ", "pyi"=>"ピィ", "pyu"=>"ピュ", "pye"=>"ピェ", "pyo"=>"ピョ",
    "mya"=>"ミャ", "myi"=>"ミィ", "myu"=>"ミュ", "mye"=>"ミェ", "myo"=>"ミョ",
    "rya"=>"リャ", "ryi"=>"リィ", "ryu"=>"リュ", "rye"=>"リェ", "ryo"=>"リョ",
    "lya"=>"リャ", "lyi"=>"リィ", "lyu"=>"リュ", "lye"=>"リェ", "lyo"=>"リョ"
  }
end
