bitcoin-splitter
================

A simple ruby script that uses electrum to split funds coming to one address to two different addresses.

We bought a miner with a friend and we want to split the rewards in half, preferably automatically.

Installation
------------

This script uses only standard library and calls command line electrum client. It needs to have "addresstosplit" in the wallet.

No race conditions were tested for, as both destination addresses are friendly in my use-case. It may have significant problems if the wallet is used for other things, I have a separate user for this with a special wallet. I have no idea what happens if other addresses have some balance, I have not tested for this case.

Electrum has to be 1.9 (current development version as time of this writing), because 1.8.1 does not understand paytomany command. We want to have both destination addresses in one transaction to make any race conditions or electrum run errors easier to handle.

Usage
-----

Usage: splitter.rb addresstosplit destinationaddr1 destinationaddr2 [fee]

Any confirmed coins coming to addresstosplit will be split to destinationaddr1 and destinationaddr2 (minus the fee).
Example: addresstosplit has 1BTC, fee is 0.0001 (default), destinationaddr1 and destinationaddr2 both receive 0.49995 BTC

FAQ
---

Q: Why did you not use [sx](http://sx.dyne.org/)? 

A: Because it does not compile on any system I use. Electrum is quite portable.

Author and Donations
--------------------

This small script was written by [Juraj Bednar](http://juraj.bednar.sk/about-me/).

If you find this useful, please donate to 14Svhg5GiZEsCpKihy46w1V6mhPiz53UxV
