#!/usr/bin/ruby

require 'shellwords'
require 'json'

ELECTRUM_COMMAND="electrum"

def electrum(*args)
 output = `#{ELECTRUM_COMMAND} #{Shellwords.join(args)} 2>/dev/null`
 if $? != 0
   raise "Electrum quit with exit code #{$?}, output was #{output}"
 end
 output
end


if ARGV.size < 3
	puts "Usage: splitter.rb changeaddress destinationaddr1 destinationaddr2 [maximumexpectedfee] [balancethreshold]"
  exit
end

change_address=ARGV.shift
address_1=ARGV.shift
address_2=ARGV.shift
# this is not the fee that is going to be paid, but maximum expected fee
# we let the client calculate the fee
fee=(ARGV.shift || 0.0010).to_f
threshold=(ARGV.shift || 0.0).to_f

begin
				balances=JSON.parse(electrum("getbalance"))
				unconfirmed=balances["unconfirmed"]
				# we want transactions to be confirmed before continuing
				if unconfirmed.nil? or unconfirmed=="0"
								# we let the client calculate the fee, as we don't know the size of transaction
								# "fee" is maximum expected fee
								balance=balances["confirmed"].to_f-fee

								if balance>threshold
									amount=(balance-fee)/2
									electrum("paytomany","-c",change_address,address_1,amount.to_s,address_2,amount.to_s)
								end
				end

rescue Exception => e  
  puts e.message  
  puts e.backtrace.inspect
end
