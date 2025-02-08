# Use the official Keycloak image (Quarkus-based)
FROM quay.io/keycloak/keycloak:latest

# ----------------------------
# Basic Admin Configuration
# ----------------------------
# For production, override these via Render’s environment variables.
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# ----------------------------
# Database Configuration
# ----------------------------
# Specify the database vendor and connection parameters.
ENV KC_DB=postgres
ENV KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_PORT=${KC_DB_URL_PORT}
ENV KC_DB_URL_DATABASE=${KC_DB_URL_DATABASE}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}

# ----------------------------
# Custom Environment Variable
# ----------------------------
ENV ANS=default_ans_value

# ----------------------------
# Expose Port
# ----------------------------
# Although Render supplies a dynamic port via the PORT variable,
# it is good practice to include an EXPOSE instruction.
EXPOSE 8080

# ----------------------------
# Override the Default ENTRYPOINT
# ----------------------------
# The official Keycloak image sets a default ENTRYPOINT that can conflict
# with our command-line arguments. Clearing it allows our CMD to run properly.
ENTRYPOINT []

# ----------------------------
# Start Keycloak on the Render-supplied Port
# ----------------------------
# This CMD uses shell form so that the PORT variable is expanded.
# If Render provides PORT (e.g. PORT=10000), Keycloak will bind to that port.
CMD /opt/keycloak/bin/kc.sh start-dev --http-port=${PORT:-8080}
