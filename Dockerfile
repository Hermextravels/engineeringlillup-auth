# Use the official Keycloak image from Quay (adjust the version as needed)
FROM quay.io/keycloak/keycloak:21.1.1

# (Optional) Set default admin credentials. For production, consider setting these via environment variables on Render.
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Build the Keycloak distribution. This step compiles your custom configuration if needed.
RUN /opt/keycloak/bin/kc.sh build

# Expose the default port (adjust if you change the port configuration)
EXPOSE 8080

# Start Keycloak in development mode. For production, refer to the official docs.
CMD ["start-dev"]
