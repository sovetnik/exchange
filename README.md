# Exchange

This is are exmple gem for currency exchange based on CBRF rates.

## Installation

```bash
git clone git@github.com:sovetnik/exchange.git
cd exchange
```
## Usage
From exchange directory:
```bash
bin/console
```
You can create Money instance with string or symbol.
`:usd`, `:USD` and `'USD'` are allowed arguments.

```ruby
b = Exchange::Bank.new
=> #<Exchange::Bank:0x007fca74325730...
m = Exchange::Money.new(amount: 23, symbol: :usd)
b.market.convert(m, :eur)
=> #<Exchange::Money:0x007fca742c64b0 @raw_amount=0.20554078375547932749289803894e2, @symbol=:eur>
b.market.batch_convert(m, [:aud, :czk])
=> [#<Exchange::Money:0x007fca7512d710 @raw_amount=0.3052017496688525887696215027e2, @symbol=:aud>,
 #<Exchange::Money:0x007fca7512c220 @raw_amount=0.538649520327040407567945109809e3, @symbol=:czk>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

