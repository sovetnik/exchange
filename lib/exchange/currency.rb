# frozen_string_literal: true

module Exchange
  class Currency
    attr_reader :nominal, :rate
    def initialize(
      charcode:,
      nominal:,
      name:,
      rate:
    )
      @charcode = charcode
      @nominal = nominal
      @name = name
      @rate = rate
    end

    def weight
      BigDecimal.new(rate) / BigDecimal.new(nominal)
    end
  end
end
