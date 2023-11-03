#!/bin/sh

set -x -e -u

FILE_STEVENBLACK_TXT='downloads/stevenblack.txt'
FILE_STEVENBLACK_CONF='downloads/stevenblack.conf'

FILE_USER_CONF='user.conf'

FILE_OUTPUT='merged.conf'

mkdir -p ./downloads/

curl -sSL --compressed 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' > ${FILE_STEVENBLACK_TXT}

(
	egrep '^0\.0\.0\.0 +[^" ]+$' "${FILE_STEVENBLACK_TXT}" \
	| sed -r 's@^[^ ]+ (.+)$@local-zone: "\1" always_nxdomain@g'
) > ${FILE_STEVENBLACK_CONF}

cat "${FILE_USER_CONF}" "${FILE_STEVENBLACK_CONF}" > "${FILE_OUTPUT}"
