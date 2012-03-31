# coding: utf-8

require 'spec_helper'
require 'romaji'

describe Romaji do
  context 'transliterate from romaji to kana' do
    it 'should transliterate' do
      Romaji.romaji2kana('kyoumoshinaitone').should == 'キョウモシナイトネ'
      Romaji.romaji2kana('今日もshinaitone').should == '今日モシナイトネ'
      Romaji.romaji2kana('SushiNoTabetas').should == 'スシノタベタs'
      Romaji.romaji2kana('shimbashi').should == 'シンバシ'
      Romaji.romaji2kana('kinkakuji').should == 'キンカクジ'
      Romaji.romaji2kana('tottori').should == 'トットリ'
    end

    it 'should transliterate with kana_type' do
      Romaji.romaji2kana('kyoumoshinaitone', :kana_type => :hiragana).should == 'きょうもしないとね'
    end
  end

  it 'should transliterate from kana to romaji' do
    Romaji.kana2romaji('キョウモシナイトネ').should == 'kyoumoshinaitone'
    Romaji.kana2romaji('すしのたべたさ').should == 'sushinotabetasa'
    Romaji.kana2romaji('シンバシ').should == 'shimbashi'
    Romaji.kana2romaji('キンカクジ').should == 'kinkakuji'
    Romaji.kana2romaji('トットリ').should == 'tottori'
  end
  
  describe Romaji::StringExtension do
    before  do
      @kana = 'ｽｼ'
      @romaji = 'ｓＵsｈi'
      @kana.extend(Romaji::StringExtension)
      @romaji.extend(Romaji::StringExtension)
    end

    it 'should extend String#normalize' do
      @kana.normalize.should == 'スシ'
      @kana.should == 'ｽｼ'

      @romaji.normalize.should == 'sushi'
      @romaji.should == 'ｓＵsｈi'
    end

    it 'should extend String#normalize!' do
      @kana.normalize!
      @kana.should == 'スシ'

      @romaji.normalize!
      @romaji.should == 'sushi'
    end

    it 'should extend String#kana' do
      @kana.kana.should == 'スシ'
      @romaji.kana.should == 'スシ'
    end

    it 'should extend String#kana!' do
      @kana.kana!
      @kana.should == 'スシ'

      @romaji.kana!
      @romaji.should == 'スシ'
    end

    it 'should extend String#romaji' do
      @kana.romaji.should =='sushi'
      @romaji.romaji.should == 'sushi'
    end

    it 'should extend String#romaji!' do
      @kana.romaji!
      @kana.should == 'sushi'

      @romaji.romaji!
      @romaji.should == 'sushi'
    end
  end
end
