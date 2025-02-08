#!/bin/sh
exec /opt/keycloak/bin/kc.sh start --optimized --http-port=${PORT:-8080} --http-host=0.0.0.0
