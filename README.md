# Introduction

Bitsy is a Bitcoin payment server that your application can talk to to create "Payment Depots" with certain characteristics. A "Payment Depot" is a Bitcoin address, but the Bitsy will do certain things with the money it recieves.

# Security

Since we're not used to handling actual money on the server, perhaps its best to keep it there the *least amount of time possible*. We should still make sure that our server is secure, but we can minimize the risk by moving the money quickly. That's what Bitsy was originally designed to do: be a forwarder of some kind.

# Types of Payment Depots

The payment depot that will be available is the `forwarder` with specific characteristics, such as:

- Ability to collect a tax on the payment (perhaps your site collects a fee), and forward the tax to the tax address
- Send the rest to the "owner" (perhaps a merchant on your website)

There could be other types in the future, but this all I (Ramon Tayag) need for now.
