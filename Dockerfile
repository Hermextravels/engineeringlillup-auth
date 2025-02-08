# Use the official Keycloak image (Quarkus-based)
FROM quay.io/keycloak/keycloak:latest

# ----------------------------
# Basic Admin Configuration
# ----------------------------
# Set default admin credentials.
# Override these in Render's environment variables for production use.
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# ----------------------------
# Database Configuration
# ----------------------------
# Specify the database vendor. In this case, PostgreSQL.
ENV KC_DB=postgres

# These database connection variables are expected to be provided by Render.
# Replace these default values or set them in Render's dashboard:
ENV KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_PORT=${KC_DB_URL_PORT}
ENV KC_DB_URL_DATABASE=${KC_DB_URL_DATABASE}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}

# ----------------------------
# Custom Environment Variable
# ----------------------------
# Set the custom environment variable ANS with a default value.
# This value can also be overridden in Render's environment settings.
ENV ANS=default_ans_value

# ----------------------------
# Expose Port and Start Keycloak
# ----------------------------
# Expose port 8080 (for documentation). Render will assign a dynamic port using the PORT variable.
EXPOSE 8080

# Start Keycloak in development mode, binding to the Render-supplied port.
CMD ["sh", "-c", "/opt/keycloak/bin/kc.sh start-dev --http-port=${PORT:-8080}"]
