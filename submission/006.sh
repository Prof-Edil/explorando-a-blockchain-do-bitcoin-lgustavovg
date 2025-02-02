# Which tx in block 257,343 spends the coinbase output of block 256,128?

# Bloco 256,128
hash256128=$(bitcoin-cli getblockhash 256128)
tx_cb=$(bitcoin-cli getblock $hash256128 | jq -r '.tx[0]') # A transação coinbase geralmente é a primeira do bloco

# Bloco 257,343
hash257343=$(bitcoin-cli getblockhash 257343)
txblock=$(bitcoin-cli getblock $hash257343 | jq -r '.tx[]')

for txid in $txblock; do
    
    clean_txid=$(echo "$txid" | tr -d '[:space:]') # Remover espaços e caracteres extras do txid
    inputs=$(bitcoin-cli getrawtransaction "$clean_txid" 1 | jq -r '.vin[].txid')

    for input in $inputs; do
        clean_input=$(echo "$input" | tr -d '[:space:]')  # Remover espaços e caracteres extras do input
        if [[ "$clean_input" == "$tx_cb" ]]; then
            echo $clean_txid
            exit 0
        fi
    done
done
