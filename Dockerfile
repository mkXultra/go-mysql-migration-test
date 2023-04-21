FROM golang:1.19-alpine3.16 AS builder
# FROM migrate/migrate:sqlite

RUN apk add --no-cache git gcc musl-dev make
RUN git clone https://github.com/golang-migrate/migrate/ /go/src/github.com/golang-migrate/migrate
WORKDIR /go/src/github.com/golang-migrate/migrate
RUN git checkout v4.15.2 
#  e.g. v4.1.0
# Go 1.15 and below
RUN go build -tags 'sqlite3' -ldflags="-X main.Version=$(git describe --tags)" -o /go/bin/migrate /go/src/github.com/golang-migrate/migrate/cmd/migrate
# Go 1.16+
RUN go install -tags 'sqlite3' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.15.2

WORKDIR $HOME

# ENTRYPOINT [ "/bin/ash" ]
ENTRYPOINT ["migrate"]