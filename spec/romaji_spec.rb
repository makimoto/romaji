# coding: utf-8

require 'spec_helper'
require 'romaji'

describe Romaji do
  context 'transliterate from romaji to kana' do
    it 'should transliterate' do
      Romaji.romaji2kana('kyoumoshinaitone').should == 'キョウモシナイトネ'
      Romaji.romaji2kana('SushiNoTabetas').should == 'スシノタベタs'
    end

    it 'should transliterate with kana_type' do
      Romaji.romaji2kana('kyoumoshinaitone', :kana_type => :hiragana).should == 'きょうもしないとね'
    end
  end

  it 'should transliterate from kana to romaji' do
    Romaji.kana2romaji('キョウモシナイトネ').should == 'kyoumoshinaitone'

    pending 'not impl\'ed'
    Romaji.kana2romaji('すしのたべたさ').should == 'sushinotabetasa'
  end
  
  describe Romaji::StringExtension do
    before  do
      @sushi = 'ｽｼ'
      @abc = 'ａＢC'
      @sushi.extend(Romaji::StringExtension)
      @abc.extend(Romaji::StringExtension)
    end

    it 'should extend String#normalize' do
      @sushi.normalize.should == 'スシ'
      @sushi.should == 'ｽｼ'

      @abc.normalize.should == 'abc'
      @abc.should == 'ａＢC'
    end

    it 'should extend String#normalize!' do
      @sushi.normalize!
      @sushi.should == 'スシ'

      @abc.normalize!
      @abc.should == 'abc'
    end
  end
end
