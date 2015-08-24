require 'bigdecimal'
require 'pry'
require 'rest-client'
require_relative './currency-converter'
require_relative './symbol_tags'
require_relative './questrade_api'

api = Questrade::API.new()
api.authorize

symbols = api.symbols
quotes = api.quotes

getCAD = ETF::CurrencyConverter.method(:getCAD)

puts "Symbol\tDescription\tAsk\tType\tSub-type"

quotes.sort.each do |symbol_code, q|
	symbol = symbols[symbol_code]
	tags = $SYMBOL_TAGS[symbol_code]
	description = symbol["description"]

	begin
		ask_price = getCAD.call(symbol["currency"], q["askPrice"] || q["lastTradePrice"])

		puts "#{q["symbol"]}\t#{description}\t#{ask_price}\t#{tags[:market]}-#{tags[:type]}\t#{tags[:sub_type]}"
	rescue Exception => e
		puts "#{e} for #{symbol}"
		exit
	end
end
puts "\n\n"


accounts_info = api.accounts

puts "Account\tSymbol\tDescription\tQuantity\tMarket Value\tArea\tSub-area"
accounts_info.each do |raw_account|
	account_id = raw_account["number"]
	positions = api.positions(account_id)

	positions.sort.each do |symbol_code, position|
		symbol = position["symbol"]
		tags = $SYMBOL_TAGS[symbol]

		raise "No tags defined for #{symbol}" if tags == nil

		symbol_info = symbols[symbol_code]
		description = symbol_info["description"]
		currency_code = symbol_info["currency"]

		market_value  = getCAD.call(currency_code, position["currentMarketValue"] || 0)
		open_quantity = BigDecimal.new(position["openQuantity"], 10)

		if tags[:splits]
			tags[:splits].each do |market_type, split_percentage|
				split_value = (market_value * (split_percentage/100))
				split_quantity = (open_quantity * (split_percentage/100))

				puts "#{raw_account["type"]}\t'#{symbol}\t#{description}\t#{split_quantity}\t#{split_value.to_f}\t#{market_type}-#{tags[:type]}"
			end
		else
			puts "#{raw_account["type"]}\t'#{symbol}\t#{description}\t#{open_quantity}\t#{market_value}\t#{tags[:market]}-#{tags[:type]}\t#{tags[:sub_type]}"
		end
	end

	balance_cad = api.get_account_balance(account_id)
	puts "#{raw_account["type"]}\t'Cash\t\t\t#{balance_cad}"
end

average_entry_prices = {}

accounts_info.each do |raw_account|
	account_id = raw_account["number"]
	positions = api.positions(account_id)

	positions.each do |symbol_code, position|
		symbol = position["symbol"]
		tags = $SYMBOL_TAGS[symbol]

		raise "No tags defined for #{symbol}" if tags == nil

		symbol_info = symbols[symbol_code]
		description = symbol_info["description"]
		currency_code = symbol_info["currency"]

		if !average_entry_prices.has_key?(symbol)
			average_entry_prices[symbol] = {
				description: description,
				market_value: BigDecimal.new(0, 10),
				average_entry_price: [],
				open_quantity: 0
			}
		end

		market_value  = getCAD.call(currency_code, position["currentMarketValue"] || 0)
		average_entry_price = getCAD.call(currency_code, position["averageEntryPrice"] || 0)
		if market_value > 0
			average_entry_prices[symbol][:market_value]+= market_value
			average_entry_prices[symbol][:average_entry_price].push(average_entry_price)
			average_entry_prices[symbol][:open_quantity]+= position["openQuantity"].to_i
		end
	end
end

puts "Symbol\tDescription\tOpen Quantity\tAverage Entry Price"
average_entry_prices.sort.each do |symbol_code, price_info|
	sum = price_info[:average_entry_price].inject(BigDecimal.new(0, 10)) do |running_total, average|
		running_total+= average
	end
	average_entry_price = sum / price_info[:average_entry_price].length

	puts "#{symbol_code}\t#{price_info[:description]}\t#{price_info[:open_quantity]}\t#{average_entry_price}"
end
