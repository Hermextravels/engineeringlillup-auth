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

# Build the Keycloak server with optimizations and bind to the port during build
RUN /opt/keycloak/bin/kc.sh build --http-port=$PORT --http-host=0.0.0.0

# Start Keycloak with the resolved port
CMD ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
