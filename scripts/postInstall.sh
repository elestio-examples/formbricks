#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;


docker-compose exec -T postgres sh -c "psql -U postgres formbricks <<EOF
\c formbricks
CREATE EXTENSION pgcrypto;
INSERT INTO User (name, email, password, onboardingCompleted) VALUES ('root', '${ADMIN_EMAIL}', crypt('${ADMIN_PASSWORD}', gen_salt('bf', 8)), 'false');
EOF";
