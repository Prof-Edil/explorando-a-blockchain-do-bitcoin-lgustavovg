# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

tx="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
# Geralmente o .txinwitness[0] é a assinatura, o [1] é a chave publica e o [2] é a chave publica que foi usada na assinatura
# O [4:70] siginifica o intervalo da chave publica
transaction=$(bitcoin-cli getrawtransaction $tx 1 | jq -r .vin[0].txinwitness[2][4:70]) 
echo $transaction
