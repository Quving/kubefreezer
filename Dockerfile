FROM alpine:latest

LABEL maintainer="vinh-ngu@hotmail.com"

RUN apk add curl vim bash ncurses

# Install kubectl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN ln -s /kubectl /usr/bin/kubectl

WORKDIR /app
COPY freeze.sh freeze.sh
RUN chmod u+x freeze.sh

CMD ["./freeze.sh"]
