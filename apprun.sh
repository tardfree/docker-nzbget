#!/bin/sh

# delete lock file if found
if [ -f /downloads/nzbget.lock ]; then
	rm /downloads/nzbget.lock
fi

# check if config exists in /config, copy if not
if [ ! -e /config/nzbget.conf ]; then
	cp /app/nzbget.conf /config/nzbget.conf
fi

/app/nzbget -s -c /config/nzbget.conf -o OutputMode=log
