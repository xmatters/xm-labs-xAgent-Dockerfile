#!/bin/bash
set -e

export WEBSOCKET_HOST="${WEBSOCKET_HOST:=$XMATTERS_HOSTNAME}"
: "${WEBSOCKET_HOST:?WEBSOCKET_HOST or XMATTERS_HOSTNAME env var must be set}"
export WEBSOCKET_SECRET="${WEBSOCKET_SECRET:=$XMATTERS_KEY}"
: "${WEBSOCKET_SECRET:?WEBSOCKET_SECRET or XMATTERS_KEY env var must be set}"
export OWNER_API_KEY="${OWNER_API_KEY:=$API_KEY}"
: "${OWNER_API_KEY:?OWNER_API_KEY or API_KEY env var must be set}"

create_prefs() {
    local FRIENDLY_NAME=$1
    local PREFS="${HOME}/.java/.userPrefs/com/xmatters/xagent/services/prefs.xml"
    local PREFS_DIR=
    PREFS_DIR=$(dirname "${PREFS}")

    echo "Creating prefs directory: ${PREFS_DIR}"
    mkdir -p "${PREFS_DIR}"
    echo "Creating ${PREFS} with ${FRIENDLY_NAME}"
    cat > "${PREFS}" << EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE map SYSTEM "http://java.sun.com/dtd/preferences.dtd">
<map MAP_XML_VERSION="1.0">
  <entry key="id" value="${FRIENDLY_NAME}"/>
</map>
EOF
}

if [ "$1" = "start" ]; then
    if [ -n "${FRIENDLY_NAME}" ]; then
        create_prefs "${FRIENDLY_NAME}"
    else
        create_prefs "${HOSTNAME}"
    fi

    exec /opt/xmatters/xa/bin/systemd.start.sh
fi

exec "$@"
