
#!/bin/bash

cd ../
declare component="${PWD##*/}"
cd ./docker-builder

echo ""
echo ""
echo "********************************************************"
echo "********************************************************"
echo " | Component: "$component
echo "********************************************************"
echo "********************************************************"
echo ""


rm -rf temp
mkdir temp
cp -r ./../algorithm ./../input_sample ./../output_sample ./temp/

docker build . \
-t docker.polly.elucidata.io/$1:latest

# rm -rf temp

docker run \
-e EXE_TYPE='TESTING' \
-e BYPASS_ALGO='NO' \
-e io_file_URL='https://d3o38qf4lx29ku.cloudfront.net/2636/16a65772-c69e-4fd0-98b5-c753c37e38cf/STUDIO_IO_FILE/0/1583920257.json?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kM28zOHFmNGx4MjlrdS5jbG91ZGZyb250Lm5ldC8yNjM2LzE2YTY1NzcyLWM2OWUtNGZkMC05OGI1LWM3NTNjMzdlMzhjZi9TVFVESU9fSU9fRklMRS8wLzE1ODM5MjAyNTcuanNvbiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTU4MzkyMzg1N319fV19&Signature=LjCqzLOj7p4zrZoK6PArJp5AW3JZ4CpG7YmClIt9ERde18qRLYY071MrOw1aDku3Q6TAVTL82aVp4pz5DP8l-WrvfzzgTPK4wAevH1detV3rnr8qxfIYoLDBjRRKnEbxP-B5BN7Z4FkmCY9RWqkaJFeSd1vhX0n1eTqWtMTL~CaGyy2bz8qx4-IM7LrGOXvItIJc3Jzr4Ps1S5URPF8VtAa4tnzSq~5TQ7jpDES25HRBEApsew3Cob~C6fvw7uAX02SEqd3PGyF4ih2wPp9GP3OZxOE4gF0qZ1Z7fovLIfC2JAZRtTHt8Q4mdT~WHR1STF3ZmXO8FWjGW8EOovwP3Q__&Key-Pair-Id=APKAJNPA6N3IYW6RF7AQ' \
-e workspace_id='xyz' \
-e analysis_id='xyz' \
-e job_index='xyz' \
-e docker_tag='xyz' \
-it docker.polly.elucidata.io/$1:latest /bin/bash \
