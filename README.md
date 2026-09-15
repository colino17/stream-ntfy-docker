# Stream NTFY (Docker)
A simply docker container to run a cron job that pulls down an M3U and checks to see if the streams are UP/DOWN. If they are down then a notification can be sent via NTFY.

## Example Docker Compose

This compose snippet can be used to deploy the container. You need to add a target M3U to check using the M3U_URL environment variable and also a NTFY_URL environment variable to receive notifications.

```yaml
  stream-ntfy:
    image: ghcr.io/colino17/stream-ntfy-docker:latest
    container_name: stream-ntfy
    restart: always
    environment:
      - M3U_URL=https://raw.githubusercontent.com/iptv-org/iptv/refs/heads/master/streams/ca.m3u
      - NTFY_URL=https://ntfy.sh/mytopic
      - TZ=Canada/Atlantic
```
