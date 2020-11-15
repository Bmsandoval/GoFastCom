FROM golang:1.13-buster
LABEL os=linux
LABEL arch=armhf

RUN apt update
RUN apt install -y cron

# Copy cron file to the cron.d directory
ADD cron /etc/cron.d/speedy-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/speedy-cron

# Apply cron job
RUN crontab /etc/cron.d/speedy-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# setup golang dependencies
WORKDIR /gofastcom
ADD go.mod .
ADD go.sum .
RUN go mod download

# Run the command on container startup
CMD ["cron", "-f"]
#ENTRYPOINT go run . measure

