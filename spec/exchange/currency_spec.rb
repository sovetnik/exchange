# frozen_string_literal: true

require_relative '../spec_helper'

describe Exchange::Currency do
  # subject { Exchange::Currency.new }

  let :czk do
    Exchange::Currency.new(
      charcode: 'CZK',
      name: 'Чешских крон',
      nominal: '10',
      rate: '24.3395'
    )
  end

  describe 'weight' do
    it 'returnes bigdecimal' do
      _(czk.weight).must_be_instance_of BigDecimal
    end
    it 'is a ratio to base currency' do
      _(czk.weight.to_f).must_equal 2.43395
    end
  end
end
