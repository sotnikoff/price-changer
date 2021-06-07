# "https://rest.coinapi.com/v1/exchangerate/BTC/EUR"

require 'HTTParty'
require 'json'

# res = HTTParty.get(
#   "https://rest.coinapi.io/v1/exchangerate/BTC/EUR", 
#   headers: {
#     "X-CoinAPI-Key": "D0538D3B-D286-415E-BD36-CC5600635B45"
#   }
# )

raise 'config not provided' unless ARGV[0]

filename = ARGV[0]

if File.exist?(filename)
  file = File.open(ARGV[0], "r")
else
  raise "Could not find config file '#{filename}'"
end

begin
  config = JSON.parse(file.read)
rescue JSON::ParserError
  raise "Could not parse config"
end

res = HTTParty.get(
  config['api_endpoint'], 
  headers: {
    "X-CoinAPI-Key": config['api_key']
  }
)

parsed = JSON.parse(res.body)

File.open("out.txt", "w") {|f| f.write(parsed['rate']) }
