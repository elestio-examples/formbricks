#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;


# docker-compose exec -T database sh -c "psql -U postgres postgres <<EOF
# \c cal
# CREATE EXTENSION pgcrypto;
# INSERT INTO users (username, name, email, password, role, locale) VALUES ('admin', 'admin', '${ADMIN_EMAIL}', crypt('${ADMIN_PASSWORD}', gen_salt('bf', 8)), 'ADMIN', 'en');
# EOF";

# sleep 10s;