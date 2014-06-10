## Introduction

*Bitsy is under active development and not yet used in production.*

Bitsy is a Rails engine to enable a Bitcoin payment server. Other applications in your ecosystem can talk to the app with Bitsy mounted to create "Payment Depots" with certain characteristics. A "Payment Depot" is a Bitcoin address, but the Bitsy will do certain things with the money it recieves.

## Security

Since we're not used to handling actual money on the server, perhaps its best to keep it there the *least amount of time possible*. We should still make sure that our server is secure, but we can minimize the risk by moving the money quickly. That's what Bitsy was originally designed to do: be a forwarder of some kind.

## Types of Payment Depots

The payment depot that will be available is the `forwarder` with specific characteristics, such as:

- Ability to collect a tax on the payment (perhaps your site collects a fee), and forward the tax to the tax address
- Send the rest to the "owner" (perhaps a merchant on your website)

There could be other types in the future, but this all I (Ramon Tayag) need for now.

## Installation

From your Rails app, add the `bitsy` gem to your Gemfile. Then:

```
rails g bitsy:config
rake bitsy:install:migrations
```

## Contributing

I suggest you do your development in this [Vagrant box](https://github.com/ramontayag/ruby-bitcoin-box). I use it for my development.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you find this useful, consider sharing some BTC love: `1PwQWijmJ39hWXk9X3CdAhEdExdkANEAPk`
