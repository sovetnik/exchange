# frozen_string_literal: true

module Exchange
  class Market
    attr_reader :date

    def initialize(date:, rates:)
      @date = date
      @rates = rates
    end

    def currency(symbol)
      @rates[symbol] || raise('Wrong symbol')
    end

    def convert(money, symbol)
      Exchange::Money.new(
        amount: money.raw_amount * ratio(money.symbol, symbol),
        symbol: symbol
      )
    end

    def batch_convert(money, symbols)
      symbols.map { |sym| convert(money, sym) }
    end

    def ratio(numerator, denominator)
      currency(numerator).weight / currency(denominator).weight
    end
  end
end
