# --- Builder Stage ---
FROM quay.io/keycloak/keycloak:21.1.1 as builder
RUN /opt/keycloak/bin/kc.sh build

# --- Final Stage ---
FROM quay.io/keycloak/keycloak:21.1.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Expose the dynamic port
EXPOSE 8080

# Environment variables for Keycloak
ENV KC_DB_VENDOR=${DB_VENDOR}
ENV KC_DB_URL=jdbc:${DB_VENDOR}://${DB_ADDR}:${DB_PORT}/${DB_DATABASE}
ENV KC_DB_USERNAME=${DB_USER}
ENV KC_DB_PASSWORD=${DB_PASSWORD}
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENV KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}
ENV KC_PROXY_ADDRESS_FORWARDING=${PROXY_ADDRESS_FORWARDING}
ENV KC_HOSTNAME=${RENDER_EXTERNAL_URL}

# Entry point
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# Start Keycloak with optimized options
CMD ["start", "--optimized", "--http-port", "${PORT:-8080}"]
