# Stream NTFY (Docker)
A simply docker container to run a cron job that pulls down an M3U and checks to see if the streams are UP/DOWN. If they are down then a notification can be sent via NTFY.

## Example Docker Compose

This compose snippet can be used to deploy the container.

```yaml
  stream-ntfy:
    image: ghcr.io/colino17/stream-ntfy-docker:latest
    container_name: stream-ntfy
    restart: always
    environment:

      - TZ=Canada/Atlantic
    volumes:
      - /path/to/XXX/files:/XXX
```
