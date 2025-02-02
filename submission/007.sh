# Only one single output remains unspent from block 123,321. What address was it sent to?

hash=$(bitcoin-cli getblockhash 123321)
tx=$(bitcoin-cli getblock $hash | jq -r .tx[])

for txid in $tx; do
    clean_txid=$(echo "$txid" | tr -d '[:space:]') # Remover espaços e caracteres extras do txid
    transactions=$(bitcoin-cli getrawtransaction $clean_txid 1 | jq .vout[])
    for index in $(echo $transactions | jq -r .n); do
        clean_input=$(echo "$index" | tr -d '[:space:]')  # Remover espaços e caracteres extras do input
        
        verify=$(bitcoin-cli gettxout $clean_txid $clean_input)
        if [[ ! -z $verify ]]; then
            address=$(echo $verify | jq -r .scriptPubKey.address)
            echo $address
            exit 0
        fi
    done
done
