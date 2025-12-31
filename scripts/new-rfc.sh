#!/usr/bin/env bash
set -euo pipefail

if [ "${1-}" = "" ]; then
  echo "Usage: scripts/new-rfc.sh ComponentName [directory] [jsx|tsx]"
  exit 1
fi

name="$1"
dir="${2:-src/components}"
ext="${3:-jsx}"

case "$ext" in
  jsx|tsx) ;;
  *) echo "Invalid extension: $ext (use jsx or tsx)"; exit 1 ;;
esac

mkdir -p "$dir"
file="$dir/$name.$ext"

if [ "$ext" = "tsx" ]; then
  cat > "$file" <<EOF
import React from 'react';

type ${name}Props = {
};

function ${name}(props: ${name}Props) {
  return (
    <div>${name}</div>
  );
}

export default ${name};
EOF
else
  cat > "$file" <<EOF
import React from 'react';

function ${name}(props) {
  return (
    <div>${name}</div>
  );
}

export default ${name};
EOF
fi

echo "Created: $file"
