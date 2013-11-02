bitcoin-splitter
================

A simple ruby script that uses electrum to split funds from wallet to two different addresses.

We bought a miner with a friend and we want to split the rewards in half, preferably automatically.

Installation
------------

This script uses only standard library and calls command line electrum client. It needs to have "addresstosplit" in the wallet.

No race conditions were tested for, as both destination addresses are friendly in my use-case. Please note that it splits balance from ALL ADDRESSES in the wallet, so please do not use the wallet for other purposes. I run it as a separate user in my system with their own wallet.

Electrum has to be 1.9 (current development version as time of this writing), because 1.8.1 does not understand paytomany command. We want to have both destination addresses in one transaction to make any race conditions or electrum run errors easier to handle.

Usage
-----

Usage: splitter.rb changeaddress destinationaddr1 destinationaddr2 [maximumexpectedfee] [balancethreshold]

Any confirmed coins coming to the wallet will be split to destinationaddr1 and destinationaddr2 (minus the maximumexpectedfee - we
let Electrum calculate the fee, so there will be some small change in most cases).

If there are any unconfirmed coins in the wallet, this script just quits. It is supposed to be run from cron, so we split the
balances after confirmation.

Example: addresstosplit has 1BTC, fee is 0.001 (default), destinationaddr1 and destinationaddr2 both receive 0.4995 BTC and
any change (if the fee is actually smaller) goes to changeaddress.

FAQ
---

Q: Why did you not use [sx](http://sx.dyne.org/)? 

A: Because it does not compile on any system I use. Electrum is quite portable.

Author and Donations
--------------------

This small script was written by [Juraj Bednar](http://juraj.bednar.sk/about-me/).

If you find this useful, please donate to 14Svhg5GiZEsCpKihy46w1V6mhPiz53UxV
