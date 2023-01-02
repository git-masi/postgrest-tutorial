#!/bin/bash

# For reasons unknown to me, if I do not include this line:
# `ALTER DEFAULT PRIVILEGES IN SCHEMA ${DB_SCHEMA} GRANT SELECT ON TABLES TO ${DB_ANON_ROLE};`
# Then an error is thrown

psql -U ${POSTGRES_USER} <<-END
    CREATE SCHEMA IF NOT EXISTS ${DB_SCHEMA};
    CREATE ROLE ${DB_ANON_ROLE} NOLOGIN;
    CREATE ROLE ${DB_CONNECTION_ROLE} NOINHERIT LOGIN PASSWORD '${DB_CONNECTION_ROLE_PASSWORD}';
    GRANT USAGE ON SCHEMA ${DB_SCHEMA} TO ${DB_ANON_ROLE};
    ALTER DEFAULT PRIVILEGES IN SCHEMA ${DB_SCHEMA} GRANT SELECT ON TABLES TO ${DB_ANON_ROLE};
    GRANT SELECT ON ALL SEQUENCES IN SCHEMA ${DB_SCHEMA} TO ${DB_ANON_ROLE};
    GRANT SELECT ON ALL TABLES IN SCHEMA ${DB_SCHEMA} TO ${DB_ANON_ROLE};
    GRANT ${DB_ANON_ROLE} TO ${DB_CONNECTION_ROLE};
    ALTER ROLE ${DB_CONNECTION_ROLE} IN DATABASE ${POSTGRES_DB} SET pgrst.jwt_secret = "${JWT_SECRET}";
    NOTIFY pgrst, 'reload config';
END