# Lannister

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lannister'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lannister

## Usage

Transfer money:

```ruby
Lannister.transfer_money(source_account_id: 42,
                        destination_account_id: 22,
                        amount: 100_000)
```

Get balance:

```ruby
Lannister.get_balance(account_id: 42)
```

## TODO

* print money use case (a.k.a credit)
* explain about the repository

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lannister/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
