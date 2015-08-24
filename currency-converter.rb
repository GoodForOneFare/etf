require 'bigdecimal'
require 'rest-client'

module ETF
	class CurrencyConverter
		@@rate_cache = {
			"CAD-CAD" => BigDecimal.new(1)
		}

		def self.getCAD(currency_code, amount)
			if amount.is_a?(String)
				BigDecimal.new(amount, 10)
			end

			amount*= getCADRate(currency_code)
		end

		def self.getCADRate(currency_code)
			return getRate(currency_code, "CAD")
		end

		def self.getRate(source_currency, dest_currency)
			conversion_key = "#{source_currency}-#{dest_currency}"
			if @@rate_cache.has_key?(conversion_key)
				return @@rate_cache[conversion_key]
			end

			request = RestClient::Request.new(
				method: :get,
				url:    "http://api.fixer.io/latest?base=#{source_currency}&symbols=#{dest_currency}"
			)

			rate_info = JSON.parse(request.execute)

			rate_str = rate_info["rates"][dest_currency]
			raise "#{source_currency} to #{dest_currency} rate not found in #{rate_info}" if rate_str == nil

			rate = BigDecimal.new(rate_str, 5)
			@@rate_cache[conversion_key] = rate
			rate
		end
	end
end
