#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

bcryptPassword=$(htpasswd -nbBC 10 root $ADMIN_PASSWORD)
hashedPassword=$(echo "$bcryptPassword" | cut -d ':' -f 2)
target=$(docker-compose port formbricks 3000)

curl http://${target}/api/v1/users \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'pragma: no-cache' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
  --data-raw '{"name":"root","email":"'${ADMIN_EMAIL}'","password":"'${hashedPassword}'","inviteToken":null,"onboardingCompleted":false}' \
  --compressed
  
