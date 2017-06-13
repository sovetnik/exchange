# frozen_string_literal: true

require_relative '../spec_helper'

describe Exchange::Money do
  let :eur { Exchange::Money.new(amount: 20, symbol: :EUR) }
  let :usd { Exchange::Money.new(amount: 10, symbol: :USD) }

  describe 'initialize' do
    it 'requires currency and amount' do
      _(eur).must_be_instance_of Exchange::Money
      _(usd).must_be_instance_of Exchange::Money
    end
  end

  describe 'amount(accuracy: 2)' do
    let :btc { Exchange::Money.new(amount: 3.14159265359, symbol: :btc) }
    it 'has 2 digit accuracy by default' do
      _(btc.amount).must_equal 3.14
    end
    it 'we can set any accuracy' do
      _(btc.amount(accuracy: 4)).must_equal 3.1416
      _(btc.amount(accuracy: 7)).must_equal 3.1415927
    end
  end

  describe '+' do
    let :result { eur + usd }
    it 'returnes money' do
      _(result).must_be_instance_of Exchange::Money
    end
    it 'has left member currency' do
      _(result.symbol).must_equal :eur
    end
    it 'has correct amount' do
      _(result.amount).must_equal 28.94
    end
  end

  describe '-' do
    let :result { eur - usd }
    it 'returnes money' do
      _(result).must_be_instance_of Exchange::Money
    end
    it 'has left member currency' do
      _(result.symbol).must_equal :eur
    end
    it 'has correct amount' do
      _(result.amount).must_equal 11.06
    end
  end
end
