FROM alpine:latest
LABEL maintainer="robert@splat.cx" description="basic nzbget container" 

# nzbget package version
# (stable-download or testing-download)
ARG NZBGET_BRANCH="testing-download"

RUN \
	apk add --no-cache \
	    ca-certificates \
	    p7zip \
	    python2 \
	    unrar \
	    wget && \

# basic
	mkdir -p /app /config /downloads && \

# add user
	addgroup -g 1000 nzbget && \
	adduser -H -D -G nzbget -s /bin/false -u 1000 nzbget && \

# install nzbget
	NZBGET_URL=$(wget -q -O - http://nzbget.net/info/nzbget-version-linux.json | grep ${NZBGET_BRANCH} | cut -d '"' -f 4 ) && \
	wget -q ${NZBGET_URL} -O /tmp/nzbget-latest-bin-linux.run  && \
	sh /tmp/nzbget-latest-bin-linux.run --destdir /app && \

# setup default config
	sed -i -e "s#\(MainDir=\).*#\1/downloads#g" \
	       -e "s#\(ScriptDir=\).*#\1$\{MainDir\}/scripts#g" \
	       -e "s#\(WebDir=\).*#\1$\{AppDir\}/webui#g" \
	       -e "s#\(ConfigTemplate=\).*#\1$\{AppDir\}/webui/nzbget.conf.template#g" \
	    /app/nzbget.conf && \

# permissions
	chown -R nzbget:nzbget /app /config /downloads && \

# cleanup
	rm -rf /tmp/*

COPY apprun.sh /app/apprun.sh

# volume mappings
VOLUME /config /downloads
EXPOSE 6789

USER nzbget
ENTRYPOINT ["/app/apprun.sh"]
