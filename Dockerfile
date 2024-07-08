# syntax=docker/dockerfile:1

ARG VERSION=v27.0.3

ARG GO_VERSION=1.22.5

###
FROM golang:${GO_VERSION}-alpine AS builder
RUN apk add --no-cache bash file git git-daemon make rsync

RUN apk add --no-cache docker-cli docker-cli-buildx
RUN apk add --no-cache shellcheck

RUN go install mvdan.cc/gofumpt@latest
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
RUN go install gotest.tools/gotestsum@latest

ARG VERSION

WORKDIR /app
# RUN git clone https://github.com/docker/cli.git /app
# RUN git checkout -b v${VERSION} v${VERSION}
RUN git clone https://github.com/qiangli/docker-cli.git /app
RUN git checkout 5239-app-command

#
ARG HOSTOS
ARG HOSTARCH

ENV VERSION=${VERSION}
ENV GOOS=${HOSTOS}
ENV GOARCH=${HOSTARCH}
ENV HOSTOS=${HOSTOS}
ENV HOSTARCH=${HOSTARCH}

COPY ./bake.sh /bake.sh

RUN chmod +x /bake.sh

#
CMD [ "/bake.sh" ]
