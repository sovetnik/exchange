# frozen_string_literal: true

require_relative '../spec_helper'

describe Exchange::Bank do
  subject { Exchange::Bank.new(document: document) }
  let :document { Nokogiri::XML xml }
  let :xml do
    <<-XML
    <?xml version="1.0" encoding="windows-1251" ?>
    <ValCurs Date="30.03.2017" name="Foreign Currency Market">
      <Valute ID="R01010">
        <NumCode>036</NumCode>
        <CharCode>AUD</CharCode>
        <Nominal>1</Nominal>
        <Name>Австралийский доллар</Name>
        <Value>43,6748</Value>
      </Valute>
      <Valute ID="R01815">
        <NumCode>410</NumCode>
        <CharCode>KRW</CharCode>
        <Nominal>1000</Nominal>
        <Name>Вон Республики Корея</Name>
        <Value>51,1445</Value>
      </Valute>
      <Valute ID="R01820">
        <NumCode>392</NumCode>
        <CharCode>JPY</CharCode>
        <Nominal>100</Nominal>
        <Name>Японских иен</Name>
        <Value>51,3268</Value>
      </Valute>
    </ValCurs>
    XML
  end

  describe 'market' do
    it 'returnes market' do
      _(subject.market).must_be_instance_of Exchange::Market
    end
  end
end
