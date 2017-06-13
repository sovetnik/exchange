# frozen_string_literal: true

require_relative '../spec_helper'

describe Exchange::Market do
  subject do
    Exchange::Market.new(
      date: '10.06.2017',
      rates: { czk: czk, eur: eur, jpy: jpy }
    )
  end

  let :eur do
    Exchange::Currency.new(
      charcode: 'EUR',
      name: 'Евро',
      nominal: '1',
      rate: '63.7852'
    )
  end

  let :czk do
    Exchange::Currency.new(
      charcode: 'CZK',
      name: 'Чешских крон',
      nominal: '10',
      rate: '24.3395'
    )
  end

  let :jpy do
    Exchange::Currency.new(
      charcode: 'JPY',
      name: 'Японских иен',
      nominal: '100',
      rate: '51.6627'
    )
  end

  let :money { Exchange::Money.new(amount: 42, symbol: 'eur') }

  describe 'currency(symbol)' do
    let :currency { subject.currency :czk }
    it 'returnes currency' do
      _(currency).must_be_instance_of Exchange::Currency
    end
    it 'found from rates' do
      _(currency).must_equal czk
    end
  end

  describe 'convert(money, symbol)' do
    describe 'with known symbol' do
      let :converted { subject.convert(money, :czk) }
      it 'returnes money' do
        _(converted).must_be_instance_of Exchange::Money
      end
      it 'in correct currency' do
        _(converted.symbol).must_equal :czk
      end
      it 'with correct amount' do
        _(converted.amount(accuracy: 3)).must_equal 1100.671
      end
    end
    describe 'with unknown symbol' do
      let :converted { -> { subject.convert(money, :zzz) } }
      it 'raises error' do
        _(converted).must_raise 'Wrong symbol'
      end
    end
  end

  describe 'batch_convert(money, symbols)' do
    let :collection { subject.batch_convert(money, %i[czk jpy]) }
    it 'returnes array' do
      _(collection).must_be_instance_of Array
    end
    it 'contain converted money instances' do
      _(collection.size).must_equal 2
      _(collection.first).must_be_instance_of Exchange::Money
      _(collection.last).must_be_instance_of Exchange::Money
    end
    it 'money inctances has requested symbols' do
      _(collection.collect(&:symbol)).must_equal %i[czk jpy]
    end
  end

  describe 'ratio' do
    it 'returnes bigdecimal' do
      _(czk.weight).must_be_instance_of BigDecimal
    end
    it 'is a ratio to base currency' do
      _(czk.weight.to_f).must_equal 2.43395
    end
  end
end
