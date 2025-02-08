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
# This EXPOSE is for documentation purposes. The actual port will be provided by Render.
EXPOSE 8080

# ----------------------------
# Override the Default ENTRYPOINT
# ----------------------------
# The official Keycloak image defines an ENTRYPOINT that may interfere with our command.
ENTRYPOINT []

# ----------------------------
# Start Keycloak with Correct Bindings
# ----------------------------
# This CMD uses the shell to allow environment variable expansion.
# It ensures Keycloak binds to 0.0.0.0 (all interfaces) and listens on the Render-assigned port.
CMD ["sh", "-c", "/opt/keycloak/bin/kc.sh start-dev --http-host=0.0.0.0 --http-port=${PORT:-8080}"]
