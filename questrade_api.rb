require 'rest-client'

module Questrade
end

class Questrade::API
	attr_reader :api_server_url
	attr_reader :access_token

	def initialize
		@positions = {}
	end

	def read_refresh_token
		# TODO: raise exception that explains the token setup process.
		File.read("token.txt")
	end

	def auth_info
	    { 'Authorization' => "Bearer #{@access_token}" }
	end

	def login_url
		refresh_token = read_refresh_token
		"https://login.questrade.com/oauth2/token?grant_type=refresh_token&refresh_token=#{refresh_token}"
	end

	def authorize
		url = login_url
		res = RestClient.get(url)

		@access_info = JSON.parse(res)
		File.write("token.txt", @access_info["refresh_token"])

		@api_server_url = @access_info["api_server"]
		@access_token   = @access_info["access_token"]
	end

	def accounts
		@accounts ||= get_accounts
	end

	def get_accounts
		accounts_request = RestClient::Request.new(
			method: :get,
			url:    "#{@api_server_url}v1/accounts",
		    headers: auth_info
		)

		JSON.parse(accounts_request.execute)["accounts"]
	end

	def positions(account_id)
		if @positions.has_key? [account_id]
			@positions[account_id]
		else
			@positions[account_id] = get_positions(account_id)
		end

		@positions[account_id]
	end

	def get_positions(account_id)
		result = {}

		positions_request = RestClient::Request.new(
			method: :get,
			url:    "#{@api_server_url}v1/accounts/#{account_id}/positions",
		    headers: auth_info
		)

		positions = JSON.parse(positions_request.execute)["positions"]
		positions.each do |position|
			result[position["symbol"]] = position
		end

		result
	end


	def symbols
		@symbols ||= get_symbols(get_owned_symbol_ids)
	end

	def get_owned_symbol_ids
		(accounts.map do |account|
			positions(account["number"]).map do |symbol_code, info|
				info["symbolId"]
			end
		end).flatten.uniq.sort
	end


	def get_symbols(symbol_ids)
		url = "#{@api_server_url}v1/symbols?ids=#{symbol_ids.join(',')}"

		quote_request = RestClient::Request.new(
			method: :get,
			url:    url,
		    headers: auth_info
		)

		result = {}
		symbols = JSON.parse(quote_request.execute)["symbols"]
		symbols.each do |symbol|
			result[symbol["symbol"]] = symbol
		end

		result
	end


	def quotes
		@quotes ||= get_quotes(get_owned_symbol_ids)
	end


	def get_quotes(symbol_ids)
		url = "#{@api_server_url}v1/markets/quotes?ids=#{symbol_ids.join(',')}"
		quote_request = RestClient::Request.new(
			method: :get,
			url:    url,
		    headers: auth_info
		)

		result = {}
		quotes = JSON.parse(quote_request.execute)["quotes"]
		quotes.each do |quote|
			result[quote["symbol"]] = quote
		end

		result
	end

	def symbol_by_code(code)
		basic_symbol = search(code)[0]
		return nil if !basic_symbol

		url = "#{@api_server_url}v1/symbols/#{basic_symbol["symbolId"]}"

		symbol_info_request = RestClient::Request.new(
			method: :get,
			url:    url,
		    headers: auth_info
		)

		JSON.parse(symbol_info_request.execute)["symbols"][0]
	end

	def get_account_balance(account_id)
		request = RestClient::Request.new(
			method: :get,
			url:    "#{@api_server_url}v1/accounts/#{account_id}/balances",
		    headers: auth_info
		)

		response = request.execute

		balances = JSON.parse(response)["combinedBalances"]
		balance = balances.find {|b| b["currency"] == "CAD" }

		balance["cash"]
	end

	def search(prefix, offset = 0)

 		request = RestClient::Request.new(
			method: :get,
			url:    "#{@api_server_url}v1/symbols/search?prefix=#{prefix}&offset=#{offset}",
		    headers: auth_info
		)

 		response = request.execute
		# TODO: respect rate limiting headers:
		# - response.headers {:x_ratelimit_remaining=>"19068", :x_ratelimit_reset=>"1435802580"}

 		JSON.parse(response)["symbols"]
	end

	def search_all(prefix)
		offset = 0
		results = []

		begin
			results.push(search(prefix, offset))
			offset+= results.last.length

			sleep(0.1)
		end while (results.last.length == 20)

		results.flatten
	end
end