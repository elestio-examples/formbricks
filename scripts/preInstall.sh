#set env vars
set -o allexport; source .env; set +o allexport;

NEXTAUTH_SECRET=$(openssl rand -base64 32)

cat << EOT >> ./.env

NEXTAUTH_SECRET=${NEXTAUTH_SECRET}
EOT

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 2432,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT