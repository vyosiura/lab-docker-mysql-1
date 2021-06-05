#!/bin/bash

for image_id in $(docker ps -aq)
do  
    echo "Removendo o container $image_id"
    docker stop $image_id && docker rm $image_id > /dev/null
done

echo "Removendo os volumes de banco"
docker volume rm $(docker volume ls -q -f 'name=lab*')

