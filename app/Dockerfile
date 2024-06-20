# syntax=docker/dockerfile:1

FROM golang:1.21 AS build-stage

ADD . /app
WORKDIR /app/src

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-api


FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /docker-api /docker-api

EXPOSE 8080

ENTRYPOINT ["/docker-api"]