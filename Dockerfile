FROM golang:1.13-buster
LABEL os=linux
LABEL arch=armhf

RUN apt update
RUN apt install -y cron

# Copy staging-cron file to the staging-cron.d directory
ADD staging-cron /etc/cron.d/staging-cron

# Give execution rights on the staging-cron job
RUN chmod 0644 /etc/cron.d/staging-cron

# Apply staging-cron job
RUN crontab /etc/cron.d/staging-cron

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

