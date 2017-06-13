# frozen_string_literal: true

module Exchange
  class Money
    attr_reader :raw_amount, :symbol
    def initialize(amount: 0, symbol: :RUR)
      @raw_amount = BigDecimal.new(amount.to_s)
      @symbol = symbol.to_s.downcase.to_sym
    end

    def amount(accuracy: 2)
      raw_amount.round(accuracy).to_f
    end

    def +(other, market: Bank.new.market)
      product(raw_amount + market.convert(other, symbol).raw_amount)
    end

    def -(other, market: Bank.new.market)
      product(raw_amount - market.convert(other, symbol).raw_amount)
    end

    private

    def product(amount)
      self.class.new(
        symbol: symbol,
        amount: amount
      )
    end
  end
end
