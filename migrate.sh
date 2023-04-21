#!/bin/bash
docker build . -t go-migrate

# if resources/db.sqlite3 exist, delete it
if [ -e resources/db.sqlite3 ]; then
    rm ./resources/db.sqlite3 -f
fi

# execute migration
docker run -v $PWD:/root --network host go-migrate -path=/root/migrations/ -database sqlite3:///root/resources/db.sqlite3 up
