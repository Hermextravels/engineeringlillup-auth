# Use the official Keycloak image
FROM quay.io/keycloak/keycloak:latest

# Set basic admin credentials (override these in Render's environment variables)
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Configure database connection (override these in Render's environment variables)
ENV KC_DB=postgres
ENV KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_PORT=${KC_DB_URL_PORT}
ENV KC_DB_URL_DATABASE=${KC_DB_URL_DATABASE}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}

# Build the Keycloak server with optimizations
RUN /opt/keycloak/bin/kc.sh build

# Expose the dynamic port provided by the environment variable
EXPOSE ${PORT:-8080}

# Start Keycloak with the resolved port and bind to all interfaces
CMD ["/opt/keycloak/bin/kc.sh", "start", "--optimized", "--http-port=${PORT}", "--http-host=0.0.0.0"]
