# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

tx_details=$(bitcoin-cli getrawtransaction $txid 1)

pubkey0=$(echo $tx_details | jq .vin[0].txinwitness[1]) # Geralmente o .txinwitness[1] é a chave publica
pubkey1=$(echo $tx_details | jq .vin[1].txinwitness[1])
pubkey2=$(echo $tx_details | jq .vin[2].txinwitness[1])
pubkey3=$(echo $tx_details | jq .vin[3].txinwitness[1])

p2sh1of4=$(bitcoin-cli createmultisig 1 "[$pubkey0, $pubkey1, $pubkey2, $pubkey3]" | jq -r .descriptor)
p2sh_adr=$(bitcoin-cli deriveaddresses $p2sh1of4 | jq -r .[0])

echo $p2sh_adr
