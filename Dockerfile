# Chrony NTP Docker Image
FROM alpine

# hadolint ignore=DL3002
USER root

# Install The Chrony Package
# hadolint ignore=DL3018
RUN apk --update --no-cache add chrony && \
  rm -rf /var/cache/apk/* /etc/chrony && \
  touch /var/lib/chrony/chrony.drift && \
  chown chrony:chrony -R /var/lib/chrony

# Set The Work Directory And Command Points
WORKDIR /tmp
ENTRYPOINT ["chronyd"]
CMD ["-d", "-s","-f","/etc/chrony.conf"]

# Copy The Configuration Into The Container
COPY config/chrony.conf /etc/chrony.conf
