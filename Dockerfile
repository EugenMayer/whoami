FROM golang:1.10 as builder
WORKDIR /go/src/github.com/containous/whoami
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep
RUN make dependencies
RUN make build

# Create a minimal container to run a Golang static binary
FROM alpine as single
COPY --from=builder /go/src/github.com/containous/whoami/whoami .
ENTRYPOINT ["/whoami"]
EXPOSE 80

# Create a minimal container to run a Golang static binary
FROM single as multiple
RUN apk add --update supervisor \
 && rm  -rf /tmp/* /var/cache/apk/* \
 && mkdir -p /etc/supervisor/conf.d/

ADD supervisor/supervisord.conf /etc/
ADD supervisor/conf.d/ /etc/supervisor/conf.d/
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
EXPOSE 80
EXPOSE 90
EXPOSE 100