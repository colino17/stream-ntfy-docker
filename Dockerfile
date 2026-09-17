FROM alpine:latest

# ENVIRONMENT
ENV M3U_URL=""
ENV NTFY_URL=""
ENV TZ="Canada/Atlantic"

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils gnutls-utils curl wget grep bash tzdata ffmpeg

# TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ADD SCRIPT
ADD stream-ntfy.sh /
RUN chmod +x /stream-ntfy.sh

# CRON
ADD crontab /
RUN crontab crontab

# CMD
CMD ["crond", "-f"]
