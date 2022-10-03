curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_create","jsonrpc":"2.0","params":{"name":"Sushiswap-Gnosis"},"id":""}'

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_deploy","jsonrpc":"2.0","params":{"name":"Sushiswap-Gnosis","ipfs_hash":"QmW8Cbb2R4ZHWGsrYjNJKRjoKKcPeDTNK6rdipfQQaAhd6"},"id":""}'

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_create","jsonrpc":"2.0","params":{"name":"Connext-NXTPv1-Gnosis"},"id":""}'

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_deploy","jsonrpc":"2.0","params":{"name":"Connext-NXTPv1-Gnosis","ipfs_hash":"QmWq1pmnhEvx25qxpYYj9Yp6E1xMKMVoUjXVQBxUJmreSe"},"id":""}' 

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_create","jsonrpc":"2.0","params":{"name":"1Hive-GardenGC"},"id":""}'

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_deploy","jsonrpc":"2.0","params":{"name":"1Hive-GardenGC","ipfs_hash":"QmSqJEGHp1PcgvBYKFF2u8vhJZt8JTq18EV7mCuuZZiutX"},"id":""}' 

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_create","jsonrpc":"2.0","params":{"name":"Giveth-Economy-Gnosis"},"id":""}'

curl --location --request POST 'http://localhost:8020' \
--header 'Content-Type: application/json' \
--data-raw '{"method":"subgraph_deploy","jsonrpc":"2.0","params":{"name":"Giveth-Economy-Gnosis","ipfs_hash":"QmeVXKzGKSyfEQib4MzeZveJgDYJCYDMMHc1pPevWeSbsq"},"id":""}' 